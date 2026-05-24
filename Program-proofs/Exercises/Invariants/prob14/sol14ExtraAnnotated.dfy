/* file: sol14ExtraAnnotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14, with annotations
   This solution to prob14.dfy takes the opposite approach of sol14.dfy: 
   we let k start at n and decrease it until 0, instead of starting at 0 
   and increasing it until n. This also affects the definitions of S and U, 
   but the overall structure of the proof is similar. Note that we need 
   to add decreases clauses to the definitions of S and U, because their 
   recursive calls increase k, so that Dafny's default guess of 
   decreases k would not work. 
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
      //   = S(a, b, k + 1) + a[k] * U(b, k + 1)
    else S(a, b, k + 1) + a[k] * U(b, k + 1)
}

ghost function U(b: array<nat>, k: nat): int
requires k <= b.Length
decreases b.Length - k
reads b
{
    // We define U(b, k) = ∑(b[i] | i: k ≤ i < n)
    // Base case: U(b, n) = ∑(b[i] | i: n ≤ i < n) = ∑(∅) = 0
    // For k < n:
    // U(b, k)
    //   = ∑(b[i] | i: k ≤ i < n)
    //      ( split domain into k < i and i = k )
    //   = ∑(b[i] | i: k < i < n ) + ∑(b[i] | i: i = k)
    //   = ∑(b[i] | i: k + 1 ≤ i < n) + b[k]
    //      ( definition of U )
    //   = U(b, k + 1) + b[k]
  if k == b.Length then 0 else b[k] + U(b, k + 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, 0)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base cases of S and U )
    // 0 ≤ n ≤ n ∧ 0 = S(a, b, n) ∧ 0 = U(b, n)
  var s:int, u:int, k:nat := 0, 0, n;
    // J: 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(b, k)
  
  while k > 0
  invariant 0 <= k <= n && s == S(a, b, k) && u == U(b, k)
  decreases k
  {
      // J ∧ B ∧ vf = V
      // 0 < k ≤ n ∧ s = S(a, b, k) ∧ u = U(b, k) ∧ k = V > 0
      //   ( k > 0, so k - 1 is a valid index; apply definition of S )
      // 0 < k ≤ n ∧ s + (a[k - 1] ≤ b[k - 1] ? a[k - 1] * u : 0) = S(a, b, k - 1) 
      //   ∧ u = U(b, k) ∧ k = V > 0
    s := s + (if a[k - 1] <= b[k - 1] then a[k - 1] * u else 0);
      // 0 < k ≤ n ∧ s = S(a, b, k - 1) ∧ u = U(b, k) ∧ k = V > 0
      //   ( apply definition of U )
      // 0 < k ≤ n ∧ s = S(a, b, k - 1) ∧ u + b[k - 1] = U(b, k - 1) ∧ k = V > 0
    u := u + b[k - 1];
      // 0 < k ≤ n ∧ s = S(a, b, k - 1) ∧ u = U(b, k - 1) ∧ k = V > 0  
      //   ( prepare for updating k to k - 1 )
      // 0 ≤ k - 1 < n ∧ s = S(a, b, k - 1) ∧ u = U(b, k - 1) ∧ k - 1 < V
    k := k - 1;
      // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(b, k) ∧ k < V
      //   ( J is preserved, and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(b, k) ∧ k ≤ 0
    //   ( the conditions k ≤ 0 and 0 ≤ k imply k = 0 )
    // s = S(a, b, 0) ∧ u = U(b, 0)
  r := s;
    // Q: r = S(a, b, 0)
}
