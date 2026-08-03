/*  file: sol19PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, invariants, 
    solution to prob19
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../CommonSupport.dfy"
import opened CommonFunctions

ghost function S(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
  if x == 1 
  then 3 * a[0] 
  else maximum(S(a, x - 1), a[x - 1] + U(a, x))
}

ghost function U(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
  if x == 1
  then 2 * a[0] 
  else maximum(U(a, x - 1), a[x - 1] 
     + maximum(Z(a, x - 1), a[x - 1]))
}

ghost function Z(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
  if x == 1 
  then a[0] 
  else maximum(Z(a, x - 1), a[x - 1])
}

method problem19(a: array<int>) returns (r: int)
requires a.Length > 0
ensures  r == S(a, a.Length)
{
  var n:nat, k:nat := a.Length, 1;
  var z:int, u:int, s:int := a[0], 2 * a[0], 3 * a[0];

  while k < n
  invariant 1 <= k <= n
  invariant s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {
    z := maximum(z, a[k]);
    u := maximum(u, a[k] + z);
    s := maximum(s, a[k] + u);
    k := k + 1;
  }

  r := s;
}