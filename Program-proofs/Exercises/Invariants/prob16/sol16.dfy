/* file: sol16.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob16
*/

ghost function S(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 then 0 else S(a, x - 1) + Z(a, x) * U(a, x - 1)
}

ghost function U(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 then 0 else U(a, x - 1) + a[x - 1] * Z(a, x)
}

ghost function Z(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 then 0 else Z(a, x - 1) + a[x - 1]
}

method problem16(a: array<nat>) returns (r: int)
ensures r == S(a, a.Length)
{
  var n:nat := a.Length;
  var s:int, u:int, k:nat, z:int := 0, 0, 0, 0;

  while k < n
  invariant 0 <= k <= n && s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {    
    z := z + a[k];
    s := s + z * u;
    u := u + a[k] * z;
    k := k + 1;
  }

  r := s;
}