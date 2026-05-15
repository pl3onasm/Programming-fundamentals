/* file: sol15.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob15
*/

ghost function S(a: array<nat>, k: nat): int
requires k <= a.Length
reads a
{
  if k == 0 
    then 0 
    else S(a, k - 1) + 2 * a[k - 1] * U(a, k - 1) 
         + a[k - 1] * a[k - 1]
}

ghost function U(a: array<nat>, k: nat): int
requires k <= a.Length
reads a
{
  if k == 0 then 0 else U(a, k - 1) + a[k - 1]
}

method problem15(a: array<nat>) returns (r: int)
ensures  r == S(a, a.Length)
{
  var n:nat := a.Length;
  var s:int, u:int, k:nat := 0, 0, 0;

  while k < n
  invariant 0 <= k <= n && s == S(a, k) && u == U(a, k)
  decreases n - k
  {    
    s := s + 2 * a[k] * u + a[k] * a[k];
    u := u + a[k];
    k := k + 1;
  }

  r := s;
}