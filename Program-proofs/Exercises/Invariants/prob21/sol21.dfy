/* file: sol21.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob21
*/

ghost function S(a: array<int>, x: nat): int
requires x <= a.Length
decreases a.Length - x
reads a
{
  if x == a.Length then 0 else S(a, x + 1) + U(a, x)
}

ghost function U(a: array<int>, x: nat): int
requires x <= a.Length
decreases a.Length - x
reads a
{
  if x == a.Length then 0 else U(a, x + 1) + a[x] * Z(a, x)
}

ghost function Z(a: array<int>, x: nat): int
requires x <= a.Length
decreases a.Length - x
reads a
{
  if x == a.Length then 0 else Z(a, x + 1) + a[x]
}

method problem21(a: array<int>) returns (r: int)
ensures r == S(a, 0)
{
  var n:nat := a.Length;
  var s:int, u:int, z:int, k:nat := 0, 0, 0, n;
    
  while k > 0
  invariant 0 <= k <= n
  invariant s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases k
  { 
    z := z + a[k - 1];
    u := u + a[k - 1] * z;
    s := s + u;
    k := k - 1;
  }

  r := s;
}