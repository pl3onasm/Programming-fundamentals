/* file: sol14ExtraAnnotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14, with annotations
   This solution to prob14.dfy takes the opposite approach of sol14.dfy: 
   we let k start at n and decrease it until 0, instead of starting at 0 
   and increasing it until n. This also affects the definitions of S and U, 
   but the overall structure of the proof is similar. Note that we have
   to update k at the start of the loop body instead of at the end, and 
   that we need to add decreases clauses to the definitions of S and U, 
   because their recursive calls increase k, so that Dafny's default guess
   of decreases k would not work. Because of all this, although perfectly 
   correct, this solution feels somewhat less natural.
*/

ghost function S(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length
requires k <= a.Length
decreases a.Length - k
reads a, b
{
    // We define S(a, b, k) = ∑(a[i] * b[j] | i,j: k ≤ i < j < n ∧ a[i] ≤ b[i])
    // Base case: S(a, b, n) = ∑(a[i] * b[j] | i,j: n ≤ i < j < n ∧ a[i] ≤ b[i])
    //                       = ∑(∅) = 0
  if k == a.Length then 0 
    // For k < n:
    // S(a, b, k)
    //   = ∑(a[i] * b[j] | i,j: k ≤ i < j < n ∧ a[i] ≤ b[i])
    //      ( split domain into k < i and i = k )
    //   = ∑(a[i] * b[j] | i,j: k < i < j < n ∧ a[i] ≤ b[i]) 
    //     + ∑(a[k] * b[j] | j: k < j < n ∧ a[k] ≤ b[k])
    //      ( rewrite first sum to comply with def of S 
    //        and factor out constant a[k] in second sum )
    //   = ∑(a[i] * b[j] | i,j: k + 1 ≤ i < j < n ∧ a[i] ≤ b[i])
    //     + a[k] * ∑(b[j] | j: k + 1 ≤ j < n ∧ a[k] ≤ b[k]) 
    //      ( apply definition of S to first sum )
    //   = S(a, b, k + 1) + a[k] * ∑(b[j] | j: k + 1 ≤ j < n ∧ a[k] ≤ b[k])
    //      ( distinguish cases a[k] ≤ b[k] and a[k] > b[k] )
  else if a[k] > b[k] 
      //   = S(a, b, k + 1) + a[k] * ∑(b[j] | j: k + 1 ≤ j < n ∧ a[k] ≤ b[k])
      //      ( the condition a[k] > b[k] implies that the second sum is empty )
      //   = S(a, b, k + 1) + a[k] * ∑(∅)
      //   = S(a, b, k + 1) + 0
    then S(a, b, k + 1) 
      //      ( in this branch, we have a[k] ≤ b[k] )
      //   = S(a, b, k + 1) + a[k] * ∑(b[j] | j: k + 1 ≤ j < n)
      //      ( apply definition of U )
      //   = S(a, b, k + 1) + a[k] * U(a, b, k + 1)
    else S(a, b, k + 1) + a[k] * U(a, b, k + 1)
}

ghost function U(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length 
requires k <= a.Length
decreases a.Length - k
reads a, b
{
    // We define U(a, b, k) = ∑(b[i] | i: k ≤ i < n)
    // Base case: U(a, b, n) = ∑(b[i] | i: n ≤ i < n) = ∑(∅) = 0
    // For k < n:
    // U(a, b, k)
    //   = ∑(b[i] | i: k ≤ i < n)
    //      ( split domain into k < i and i = k )
    //   = ∑(b[i] | i: k < i < n ) + ∑(b[i] | i: i = k)
    //   = ∑(b[i] | i: k + 1 ≤ i < n) + b[k]
    //      ( definition of U )
    //   = U(a, b, k + 1) + b[k]
  if k == a.Length then 0 else b[k] + U(a, b, k + 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, 0)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base cases of S and U )
    // 0 ≤ n ≤ n ∧ 0 = S(a, b, n) ∧ 0 = U(a, b, n)
  var s:int, u:int, k:nat := 0, 0, n;
    // J: 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(a, b, k)
  
  while k > 0
  invariant 0 <= k <= n && s == S(a, b, k) && u == U(a, b, k)
  decreases k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(a, b, k) ∧ k = V > 0
      //   ( prepare updating k to k - 1; apply definitions of S and U )
      // 0 ≤ k - 1 < n ∧ S(a, b, k - 1) = s + (a[k - 1] ≤ b[k - 1] ? u * a[k - 1] : 0)
      //   ∧ U(a, b, k - 1) = u + b[k - 1] ∧ k - 1 < V
    k := k - 1;
      // 0 ≤ k < n ∧ S(a, b, k) = s + (a[k] ≤ b[k] ? u * a[k] : 0) 
      //   ∧ U(a, b, k) = u + b[k] ∧ k < V
    if a[k] <= b[k] {
        // 0 ≤ k < n ∧ S(a, b, k) = s + u * a[k] ∧ U(a, b, k) = u + b[k] ∧ k < V
      s := s + u * a[k];
        // 0 ≤ k < n ∧ S(a, b, k) = s ∧ U(a, b, k) = u + b[k] ∧ k < V
    }

    else 
    {   
        // In this branch, we have a[k] > b[k]
        // 0 ≤ k < n ∧ S(a, b, k) = s + 0 ∧ U(a, b, k) = u + b[k] ∧ k < V
        // 0 ≤ k < n ∧ S(a, b, k) = s ∧ U(a, b, k) = u + b[k] ∧ k < V
    }

      // Collect branches:
      // 0 ≤ k < n ∧ S(a, b, k) = s ∧ U(a, b, k) = u + b[k] ∧ k < V
    u := u + b[k];
      // 0 ≤ k < n ∧ S(a, b, k) = s ∧ U(a, b, k) = u ∧ k < V
      //   J is preserved, and the variant function vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(a, b, k) ∧ k ≤ 0
    //   ( the conditions k ≤ 0 and 0 ≤ k imply k = 0 )
    // s = S(a, b, 0) ∧ u = U(a, b, 0)
  r := s;
    // Q: r = S(a, b, 0)
}
