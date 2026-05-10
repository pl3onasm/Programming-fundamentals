/* file: sol13.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob13
   This is exercise 7.15 from the PC reader
*/

function S(a: array<real>, x: real, k: nat): real
requires k <= a.Length
decreases a.Length - k
reads a
{
  if k == a.Length then 0.0 else a[k] + x * S(a, x, k + 1)
}

method problem13(a: array<real>, x: real) returns (r: real)
ensures  r == S(a, x, 0)
{
  var n:nat := a.Length;
  var s:real, k:nat := 0.0, n;
  
  while k != 0
  invariant 0 <= k <= n && s == S(a, x, k)
  decreases k
  {
    s := a[k - 1] + x * s;
    k := k - 1;
  }

  r := s; 
}