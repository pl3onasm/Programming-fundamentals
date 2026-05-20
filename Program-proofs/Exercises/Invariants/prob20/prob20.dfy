/* file: prob20.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob20
   exam2015, april 7, problem 2
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
        {Q: r =  ∏( ∑(a[j] + a[k] | j,k: 0 ≤ j ≤ k < i) | i: 0 ≤ i < n)}
  */
}