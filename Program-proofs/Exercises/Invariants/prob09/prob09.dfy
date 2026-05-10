/* file: prob09.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob09
   This is exercise 7.11 from the PC reader
*/

function Prod(a: array<real>, k: nat := a.Length): real
requires ??
reads a
{
  ??
}

method problem09(a: array<real>) returns (p: real)
ensures p == Prod(a)
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

    const n: ℕ
    const a: array [0..n) of ℝ
    var   p: ℝ
      
      {P: true}
    T
      {Q: p = ∏(a[i] | 0 ≤ i < n)}
  */
}
