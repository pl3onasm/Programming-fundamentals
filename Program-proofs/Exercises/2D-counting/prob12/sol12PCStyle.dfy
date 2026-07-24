/*  file: sol12PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting, 
    solution to prob12
    This is exercise 9.14 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(int,int) -> int, x:int, y:int, z:int, m:nat): int
requires Ordered2DInt(h, Asc, Asc)
requires 0 < m
requires 0 <= x <= m && 0 <= y
decreases m - x + y
{
  if x >= m || y <= 0 then z
  else if h(x,y-1) < 0 
       then F(h, x+1, y, minimum(z, abs(h(x,y-1))), m)
       else F(h, x, y-1, minimum(z, abs(h(x,y-1))), m)
}

method problem12(h:(int,int) -> int, m:nat, n:nat)
returns (z:int)
requires Ordered2DInt(h, Asc, Asc)
requires 0 < m && 0 < n
ensures z == F(h,0,n,abs(h(0,0)),m)
{
  var x:int, y:int := 0, n;
  z := abs(h(0,0));

  while x < m && 0 < y
  invariant 0 <= x <= m
  invariant 0 <= y <= n
  invariant F(h,x,y,z,m) == F(h,0,n,abs(h(0,0)),m)
  decreases m - x + y
  {
    z := minimum(z, abs(h(x,y-1)));

    if h(x,y-1) < 0
    {
      x := x + 1;
    }

    else
    {
      y := y - 1;
    }
  }
}