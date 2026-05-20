/* file: prob22.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob22
   exam2017, april 7, problem 2
*/

method problem22(a: array<int>) returns (r: int)
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
        {Q: r = ∑( Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ k) | k: 0 ≤ k < n)}


    The time complexity of the command sequence T should be in O(n).
  */

}