/* file: sol14.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14
*/

ghost function S(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length
requires k <= a.Length
reads a, b
{
  if k == 0 
    then 0
    else S(a, b, k - 1) + b[k - 1] * U(a, b, k - 1)
}

ghost function U(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length 
requires k <= a.Length
reads a, b
{
  if k == 0 
    then 0 
    else if a[k - 1] <= b[k - 1]
         then a[k - 1] + U(a, b, k - 1)
         else U(a, b, k - 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, a.Length)
{
  var n:nat := a.Length;
  var s:int, u:int, k:nat := 0, 0, 0;
  
  while k < n
  invariant 0 <= k <= n && s == S(a, b, k) && u == U(a, b, k)
  decreases n - k
  {
    s := s + u * b[k];
    u := u + (if a[k] <= b[k] then a[k] else 0);
    k := k + 1;
  }

  r := s;
}
