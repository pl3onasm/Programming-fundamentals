/* file: sol13Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob13, with annotations
   This is exercise 7.15 from the PC reader
*/

function S(a: array<real>, x: real, k: nat): real
requires k <= a.Length
decreases a.Length - k
reads a
{
    // We define S(a, x, k) = ∑(a[i] * x^{i-k} | k ≤ i < n)
    // Base case: S(a, x, n) = ∑(a[i] * x^{i-n} | n ≤ i < n) = ∑(∅) = 0
    // For k < n:
    // S(a, x, k)
    //   = ∑(a[i] * x^{i-k} | k ≤ i < n)
    //      (split domain into i = k and i > k)
    //   = a[k] * x^{k-k} + ∑(a[i] * x^{i-k} | k < i < n)
    //      (rewrite x^{i-k} as x * x^{(i-1)-k} and factor out x)
    //   = a[k] + x * ∑(a[i] * x^{(i-1)-k} | k < i < n)
    //      (rewrite to comply with definition of S)
    //   = a[k] + x * ∑(a[i] * x^{i-(k+1)} | k+1 ≤ i < n)
    //      (apply definition of S)
    //   = a[k] + x * S(a, x, k + 1)
  if k == a.Length then 0.0 else a[k] + x * S(a, x, k + 1)
}

method problem13(a: array<real>, x: real) returns (r: real)
ensures  r == S(a, x, 0)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base case of S )
    // 0 ≤ 0 ≤ n ∧ 0 = S(a, x, n)
  var s:real, k:nat := 0.0, n;
    // J: 0 ≤ k ≤ n ∧ s = S(a, x, k)
  
  while k != 0
  invariant 0 <= k <= n && s == S(a, x, k)
  decreases k
  {
      // J ∧ B ∧ vf = V
      // 0 < k ≤ n ∧ s = S(a, x, k) ∧ k = V
      //   ( use definition of S(a, x, k - 1) = a[k - 1] + x * S(a, x, k);
      //     substitute S(a, x, k) for s )
      // 0 < k ≤ n ∧ a[k - 1] + x * s = S(a, x, k - 1) ∧ k = V
    s := a[k - 1] + x * s;
      // 0 < k ≤ n ∧ s = S(a, x, k - 1) ∧ k = V 
      //   ( prepare for updating k to k - 1 )
      // 0 ≤ k - 1 < n ∧ s = S(a, x, k - 1) ∧ k - 1 < V
    k := k - 1;
      // 0 ≤ k < n ∧ s = S(a, x, k) ∧ k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, x, k) ∧ k = 0
    // s = S(a, x, 0)
  r := s; 
    // Q: r = S(a, x, 0)
}