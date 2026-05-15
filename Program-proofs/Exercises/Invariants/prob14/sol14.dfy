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
    else S(a, b, k + 1) + a[k] * T(a, b, k + 1)
}

ghost function T(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length 
requires k <= a.Length
decreases a.Length - k
reads a, b
{
  if k == b.Length then 0 else b[k] + T(a, b, k + 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, 0)
{
  var n:nat := a.Length;
  var s:int, t:int, k:nat := 0, 0, n;
  
  while k > 0
  invariant k <= n && s == S(a, b, k) && t == T(a, b, k)
  decreases k
  {
    k := k - 1;

    if a[k] <= b[k]
    {
      s := s + t * a[k];
    }

    t := t + b[k];
  }

  r := s;
}