/* file: prob10.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob10
   This is exercise 7.12 from the PC reader
*/

function dotProd(a: array<real>, b: array<real>, k: nat := a.Length): real
requires ??
reads a, b
{
  ??
}

method problem10(a: array<real>, b: array<real>) returns (r: real)
requires a.Length == b.Length
ensures  r == dotProd(a, b)
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

    const n: ℕ
    const a, b: array [0..n) of ℝ
    var   r: ℝ
      
      {P: true}
    T
      {Q: r = ∑(a[i] * b[i] | 0 ≤ i < n)}
  */
}