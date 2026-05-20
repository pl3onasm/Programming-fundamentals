/* file: prob21.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob21
   exam2015, may 6, problem 2
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
        {Q: r =  ∑( ∑(a[j] * a[k] | j,k: i ≤ j ≤ k < n) | i: 0 ≤ i < n)}
  */

}