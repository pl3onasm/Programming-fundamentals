/* file: sol18.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob18
*/

ghost function S(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
  if x == 0 
    then 0 
    else S(a, x - 1) + (a[x - 1] % 2) * ((x - 1) * a[x - 1] + U(a, x - 1))
}

ghost function U(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{    
  if x == 0 then 0 else U(a, x - 1) + a[x - 1]
}

method problem18(a: array<nat>) returns (r: int)
ensures r == S(a, a.Length)
{
  var n:nat := a.Length;
  var s:int, u:int, k:nat := 0, 0, 0;

  while k < n
  invariant 0 <= k <= n
  invariant s == S(a, k) && u == U(a, k)
  decreases n - k
  {
    s := s + (a[k] % 2) * (k * a[k] + u);
    u := u + a[k];
    k := k + 1;
  }
    
  r := s;
}