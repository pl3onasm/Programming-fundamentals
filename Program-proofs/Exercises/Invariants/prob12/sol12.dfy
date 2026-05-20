/* file: sol12.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob12
   This is exercise 7.14 from the PC reader
*/

ghost function B(a: array<int>, k: nat := a.Length): int
requires k <= a.Length
reads a
{
  if k == 0 then 0 else B(a, k - 1) + a[k - 1] * C(a, k - 1)
}

ghost function C(a: array<int>, k: nat := a.Length): int
requires k <= a.Length
reads a
{  
  if k == 0 then 0 else C(a, k - 1) + a[k - 1]
}

method problem12(a: array<int>) returns (r: int)
ensures  r == B(a)
{
  var n:nat := a.Length;
  var b:int, c:int, k:nat := 0, 0, 0;
  
  while k < n
  invariant 0 <= k <= n && b == B(a, k) && c == C(a, k)
  decreases n - k
  {
    b := b + c * a[k];
    c := c + a[k];
    k := k + 1;
  }

  r := b;
}