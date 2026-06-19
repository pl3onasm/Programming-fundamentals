/* file: sol14Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14, with annotations
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