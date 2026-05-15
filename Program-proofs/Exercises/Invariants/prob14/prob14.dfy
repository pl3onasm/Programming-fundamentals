/* file: prob14.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob14
*/

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires ??
ensures  ??
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n: ℕ
      const a, b: array [0..n) of ℕ+
      var   r: ℤ
        
        {P: true}
      T
        {Q: r = ∑(a[i] * b[j] | 0 ≤ i < j < n ∧ a[i] ≤ b[i])}

    The time compplexity of T should be linear in n, the size
    of the input arrays.
  */
}