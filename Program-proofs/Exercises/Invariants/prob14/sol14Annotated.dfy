/* file: sol14Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14, with annotations
   2021 HMW3 ex1
*/

ghost function S(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length
requires k <= a.Length
decreases a.Length - k
reads a, b
{
    // We define S(a, b, k) = ∑(a[i] * b[j] | k ≤ i < j < n ∧ a[i] ≤ b[i])
    // Base case: S(a, b, n) = ∑(a[i] * b[j] | n ≤ i < j < n ∧ a[i] ≤ b[i])
    //                       = ∑(∅) = 0
  if k == a.Length then 0 
    // For k < n:
    // S(a, b, k)
    //   = ∑(a[i] * b[j] | k ≤ i < j < n ∧ a[i] ≤ b[i])
    //      ( split domain into k < i and i = k )
    //   = ∑(a[i] * b[j] | k < i < j < n ∧ a[i] ≤ b[i]) 
    //     + ∑(a[k] * b[j] | k < j < n ∧ a[k] ≤ b[k])
    //      ( rewrite first sum to comply with def of S 
    //        and factor out constant a[k] in second sum )
    //   = ∑(a[i] * b[j] | k + 1 ≤ i < j < n ∧ a[i] ≤ b[i])
    //     + a[k] * ∑(b[j] | k + 1 ≤ j < n ∧ a[k] ≤ b[k]) 
    //      ( apply definition of S to first sum )
    //   = S(a, b, k + 1) + a[k] * ∑(b[j] | k + 1 ≤ j < n ∧ a[k] ≤ b[k])
    //      ( distinguish cases a[k] ≤ b[k] and a[k] > b[k] )
  else if a[k] > b[k] 
      //   = S(a, b, k + 1) + a[k] * ∑(b[j] | k + 1 ≤ j < n ∧ a[k] ≤ b[k])
      //      ( the condition a[k] > b[k] implies that the second sum is empty )
      //   = S(a, b, k + 1) + a[k] * ∑(∅)
      //   = S(a, b, k + 1) + 0
    then S(a, b, k + 1) 
      //      ( in this branch, we have a[k] ≤ b[k] )
      //   = S(a, b, k + 1) + a[k] * ∑(b[j] | k + 1 ≤ j < n)
      //      ( apply definition of T )
      //   = S(a, b, k + 1) + a[k] * T(a, b, k + 1)
    else S(a, b, k + 1) + a[k] * T(a, b, k + 1)
}

ghost function T(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length 
requires k <= a.Length
decreases a.Length - k
reads a, b
{
    // We define T(a, b, k) = ∑(b[i] | k ≤ i < n)
    // Base case: T(a, b, n) = ∑(b[i] | n ≤ i < n) = ∑(∅) = 0
    // For k < n:
    // T(a, b, k)
    //   = ∑(b[i] | k ≤ i < n)
    //      ( split domain into k < i and i = k )
    //   = ∑(b[i] | k < i < n ) + ∑(b[i] | i = k)
    //   = ∑(b[i] | k + 1 ≤ i < n) + b[k]
    //      ( definition of T )
    //   = T(a, b, k + 1) + b[k]
  if k == b.Length then 0 else b[k] + T(a, b, k + 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, 0)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base cases of S and T )
    // 0 ≤ 0 ≤ n ∧ 0 = S(a, b, n) ∧ 0 = T(a, b, n)
  var s:int, t:int, k:nat := 0, 0, n;
    // J: 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ t = T(a, b, k)
  
  while k > 0
  invariant k <= n && s == S(a, b, k) && t == T(a, b, k)
  decreases k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ t = T(a, b, k) ∧ k = V > 0
      //   ( prepare updating k to k - 1 )
      // 0 ≤ k - 1 < n ∧ S(a, b, k - 1) = s + (a[k - 1] ≤ b[k - 1] ? t * a[k - 1] : 0)
      //   ∧ T(a, b, k - 1) = t + b[k - 1] ∧ k - 1 < V
    k := k - 1;
      // 0 ≤ k < n ∧ S(a, b, k) = s + (a[k] ≤ b[k] ? t * a[k] : 0) 
      //   ∧ T(a, b, k) = t + b[k] ∧ k < V
    if a[k] <= b[k] {
        // 0 ≤ k < n ∧ S(a, b, k) = s + t * a[k] ∧ T(a, b, k) = t + b[k] ∧ k < V
      s := s + t * a[k];
        // 0 ≤ k < n ∧ S(a, b, k) = s ∧ T(a, b, k) = t + b[k] ∧ k < V
    }

    else 
    {   // In this branch, we have a[k] > b[k]
        // 0 ≤ k < n ∧ S(a, b, k) = s + 0 ∧ T(a, b, k) = t + b[k] ∧ k < V
        // 0 ≤ k < n ∧ S(a, b, k) = s ∧ T(a, b, k) = t + b[k] ∧ k < V
    }

      // Collect branches:
      // 0 ≤ k < n ∧ S(a, b, k) = s ∧ T(a, b, k) = t + b[k] ∧ k < V
    t := t + b[k];
      // 0 ≤ k < n ∧ S(a, b, k) = s ∧ T(a, b, k) = t ∧ k < V
      // J is preserved, and the variant function vf decreases.
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ t = T(a, b, k) ∧ k ≤ 0
    //   ( the conditions k ≤ 0 and 0 ≤ k imply k = 0 )
    // s = S(a, b, 0) ∧ t = T(a, b, 0)
  r := s;
    // Q: r = S(a, b, 0)
}
