/* file: sol08.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob08
   This is exercise 7.10b from the PC reader
*/

include "../../Support/Math.dfy"

import opened MathSupport

ghost function Max(a: array<int>, k: nat := a.Length): int
requires 0 < k <= a.Length
reads a
{
  if k == 1 then a[0] else maximum(Max(a, k - 1), a[k - 1])
}

method problem08(a: array<int>) returns (r:int)
requires a.Length > 0
ensures r == Max(a)
{ 
  var n, k := a.Length, 1;
  r := a[0];

  while k != n
  invariant 1 <= k <= n && r == Max(a, k)
  decreases n - k   
  {
    r := maximum(r, a[k]);
    k := k + 1;
  }
}