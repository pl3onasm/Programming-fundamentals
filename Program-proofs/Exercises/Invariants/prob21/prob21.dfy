/* file: prob21.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob21
*/

method problem21(a: array<int>) returns (r: int)
ensures  ??
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n: ℕ
      const a: array [0..n) of ℤ
      var   r: ℤ
        
        {P: true}
      T
        {Q: r =  ∑( ∑(a[j] * a[h] | j,h: i ≤ j ≤ h < n) | i: 0 ≤ i < n)}

    The time complexity of T should be linear in n.
  */
}