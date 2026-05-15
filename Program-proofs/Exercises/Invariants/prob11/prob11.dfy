/* file: prob11.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob11
   This is exercise 7.13 from the PC reader
*/

ghost function Cnt7(a: array<int>, k: nat := a.Length): int
requires ??
reads a
{
  ??
}

method problem11(a: array<int>) returns (r: int)
ensures  r == Cnt7(a)
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

    const n: ℕ
    const a: array [0..n) of ℤ
    var   r: ℤ
      
      {P: true}
    T
      {Q: r = #{ i | i: 0 ≤ i < n ∧ a[i] = 7 }}
  */
}