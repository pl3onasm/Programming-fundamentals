/* file: prob18.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob18
*/

method problem18(a: array<nat>) returns (r: int)
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
        {Q: r = ∑(a[i] + a[j] | i,j: 0 ≤ i < j < n ∧ a[j] mod 2 = 1)}

    The time complexity of T should be linear in n.
  */
}