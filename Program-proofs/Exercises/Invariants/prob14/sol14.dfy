/* file: sol14.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14
*/

ghost function S(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length
requires k <= a.Length
decreases a.Length - k
reads a, b
{
  if k == a.Length then 0 
  else if a[k] > b[k] 
    then S(a, b, k + 1) 
    else S(a, b, k + 1) + a[k] * U(a, b, k + 1)
}

ghost function U(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length 
requires k <= a.Length
decreases a.Length - k
reads a, b
{
  if k == b.Length then 0 else b[k] + U(a, b, k + 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, 0)
{
  var n:nat := a.Length;
  var s:int, u:int, k:nat := 0, 0, n;
  
  while k > 0
  invariant k <= n && s == S(a, b, k) && u == U(a, b, k)
  decreases k
  {
    k := k - 1;

    if a[k] <= b[k]
    {
      s := s + u * a[k];
    }

    u := u + b[k];
  }

  r := s;
}