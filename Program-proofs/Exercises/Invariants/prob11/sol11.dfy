/* file: sol11.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob11
   This is exercise 7.13 from the PC reader
*/

function Ord(b: bool): int
{
  if b then 1 else 0
}

ghost function Cnt7(a: array<int>, k: nat := a.Length): int
requires k <= a.Length
reads a
{   
  if k == 0 then 0 else Cnt7(a, k - 1) + Ord(a[k - 1] == 7)
}

method problem11(a: array<int>) returns (r: int)
ensures  r == Cnt7(a)
{
  var n:nat := a.Length;
  var x:int, k:nat := 0, 0;
  
  while k < n
  invariant 0 <= k <= n && x == Cnt7(a, k)
  decreases n - k
  {
    x := x + Ord(a[k] == 7);
    k := k + 1;
  }

  r := x;
}