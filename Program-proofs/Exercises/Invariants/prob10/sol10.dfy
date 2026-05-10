/* file: sol10.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob10
   This is exercise 7.12 from the PC reader
*/

function dotProd(a: array<real>, b: array<real>, k: nat := a.Length): real
requires a.Length == b.Length
requires k <= a.Length
reads a, b
{
  if k == 0 then 0.0 else dotProd(a, b, k - 1) + a[k - 1] * b[k - 1]
}

method problem10(a: array<real>, b: array<real>) returns (r: real)
requires a.Length == b.Length
ensures  r == dotProd(a, b)
{
  var n:nat := a.Length;
  var x:real, k:nat := 0.0, 0;
  
  while k < n
  invariant 0 <= k <= n && x == dotProd(a, b, k)
  decreases n - k
  {
    x := x + a[k] * b[k];
    k := k + 1;
  }

  r := x;
}