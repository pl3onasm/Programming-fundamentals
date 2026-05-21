/* file: sol14.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14
*/

function mxm(x: int, y: int): int
{
  if x >= y then x else y
}

ghost function S(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
  if x == 1 
  then 3 * a[0] 
  else mxm(S(a, x - 1), a[x - 1] + U(a, x))
}

ghost function U(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
  if x == 1
  then 2 * a[0] 
  else mxm (U(a, x - 1), a[x - 1] + mxm (Z(a, x - 1), a[x - 1]))
}

ghost function Z(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
  if x == 1 
  then a[0] 
  else mxm (Z(a, x - 1), a[x - 1])
}

method problem19(a: array<int>) returns (r: int)
requires a.Length > 0
ensures  r == S(a, a.Length)
{
  var n:nat, k:nat := a.Length, 1;
  var z:int, u:int, s:int := a[0], 2 * a[0], 3 * a[0];

  while k < n
  invariant 1 <= k <= n
  invariant s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {
    z := mxm(z, a[k]);
    u := mxm(u, a[k] + z);
    s := mxm(s, a[k] + u);
    k := k + 1;
  }

  r := s;
}