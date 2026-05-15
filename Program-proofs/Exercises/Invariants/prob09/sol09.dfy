/* file: sol09.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob09
   This is exercise 7.11 from the PC reader
*/

ghost function Prod(a: array<real>, k: nat := a.Length): real
requires k <= a.Length
reads a
{
  if k == 0 then 1.0 else Prod(a, k - 1) * a[k - 1]
}

method problem09(a: array<real>) returns (p: real)
ensures p == Prod(a)
{
  var n:nat := a.Length;
  var x:real, k:nat := 1.0, 0;

  while k != n
  invariant 0 <= k <= n && x == Prod(a, k)
  decreases n - k
  {
    x := x * a[k];
    k := k + 1;
  }

  p := x;
}