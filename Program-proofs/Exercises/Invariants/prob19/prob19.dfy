/* file: prob19.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob19
*/

method problem19(a: array<int>) returns (r: int)
requires ??
ensures  ??
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n: ℕ
      const a: array [0..n) of ℤ
      var   r: ℤ
        
        {P: n > 0}
      T
        {Q: r = Max (a[i] + a[j] + a[h] | i,j,h: 0 ≤ i ≤ j < n ∧ i ≤ h < n)}

    The time complexity of T should be linear in n.
  */
}