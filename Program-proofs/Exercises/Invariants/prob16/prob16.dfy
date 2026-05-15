/* file: prob16.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob16
*/

method problem16(a: array<nat>) returns (r: int)
ensures  ??
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n: ℕ
      const a: array [0..n) of ℕ
      var   r: ℤ
        
        {P: true}
      T
        {Q: r = ∑( ∑(a[i] | i: 0 ≤ i ≤ k) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < k) | k: 0 ≤ k < n )}

    The time complexity of T should be linear in n.
  */
}