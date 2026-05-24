/* file: prob20.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob20
*/

method problem20(a: array<int>) returns (r: int)
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
        {Q: r =  ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < n)}

    The time complexity of T should be linear in n.
  */
}