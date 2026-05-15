/* file: prob15.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob15
*/

method problem15(a: array<nat>) returns (r: int)
ensures  ??
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n: ℕ
      const a: array [0..n) of ℕ+
      var   r: ℤ
        
        {P: true}
      T
        {Q: r = ∑(a[i] * a[j] | 0 ≤ i < n ∧ 0 ≤ j < n)}

      The time compplexity of T should be linear in n, the size
      of the input array.
  */
}