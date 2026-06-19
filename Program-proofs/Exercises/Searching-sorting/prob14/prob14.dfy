/* file: prob14.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob14
*/

function S(a: array<nat>, k: nat := a.Length): nat
requires ??
reads a
{
  ??
}

method problem14(a: array<nat>) returns (r: nat)
ensures  r == S(a)
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

      const n, w: ℕ
      const a: array [0..n) of ℕ
      var   x: ℕ
        
        {P: M = Min{ i ∈ ℕ | n ≤ i ∨ S(a, i) > w }}
      T
        {Q: x = M}

      where S(a, x) is defined as follows:

        S(a, x) = ∑(a[i] | 0 ≤ i < x)
  */
}