/* file: sol20.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob20
*/

ghost function P(a: array<int>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 then 1 else P(a, x - 1) * S(a, x - 1)
}

ghost function S(a: array<int>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 then 0 else S(a, x - 1) + a[x - 1] * U(a, x)
}

ghost function U(a: array<int>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 then 0 else U(a, x - 1) + a[x - 1]
} 

method problem20(a: array<int>) returns (r: int)
ensures r == P(a, a.Length)
{  
  var n:nat := a.Length;
  var p:int, s:int, u:int, k:nat := 1, 0, 0, 0;

  while k < n
  invariant 0 <= k <= n 
  invariant p == P(a, k) && s == S(a, k) && u == U(a, k)
  decreases n - k
  {
    p := p * s;
    u := u + a[k];
    s := s + a[k] * u;
    k := k + 1;
  }

  r := p;
}