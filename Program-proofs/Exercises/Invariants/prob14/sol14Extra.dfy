/* file: sol14Extra.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14
   This solution to prob14.dfy takes the opposite approach of sol14.dfy: 
   we let k start at n and decrease it until 0, instead of starting at 0 
   and increasing it until n. This also affects the definitions of S and U, 
   but the overall structure of the proof is similar. Note that we need 
   to add decreases clauses to the definitions of S and U, because their 
   recursive calls increase k, so that Dafny's default guess of 
   decreases k would not work. Without the decreases clauses, Dafny would
   not be able to see that increasing k is making progress towards the 
   base cases.
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
    else S(a, b, k + 1) + a[k] * U(b, k + 1)
}

ghost function U(b: array<nat>, k: nat): int
requires k <= b.Length
decreases b.Length - k
reads b
{
  if k == b.Length then 0 else b[k] + U(b, k + 1)
}

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, 0)
{
  var n:nat := a.Length;
  var s:int, u:int, k:nat := 0, 0, n;
  
  while k > 0
  invariant k <= n
  invariant s == S(a, b, k) && u == U(b, k)
  decreases k
  {
    s := s + (if a[k - 1] <= b[k - 1] then a[k - 1] * u else 0);
    u := u + b[k - 1];
    k := k - 1;
  }

  r := s;
}