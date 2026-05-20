/* file: prob17.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob17
*/

method problem17(a: array<int>) returns (r: int)
requires ??
ensures  ??
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n: ℤ
      const a: array [0..n) of ℤ
      var   r: ℤ
        
        {P: n > 0}
      T
        {Q: r = Max (Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ k) | k: 0 ≤ k < n)}

    The time complexity of T should be in O(n).
  */
}