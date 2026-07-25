/*  file: sol08PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob08
    This is exercise 9.9 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(int,int) -> int, x:nat, y:nat, n:nat): int
requires Ordered2DInt(h, Asc, Asc)
decreases x + (n - y)
{
  if x == 0 || y >= n then 0
  else if h(x-1,y) >= 0 
       then F(h,x-1,y,n) + ord(h(x-1,y) == 0)
       else F(h,x,y+1,n)
}

method problem08(h:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(h, Asc, Asc)
ensures z == F(h,m,0,n)
{
  var x:nat, y:nat := m, 0;
  z := 0;

  while x > 0 && y < n
  invariant z + F(h,x,y,n) == F(h,m,0,n)
  decreases x + (n - y)
  {
    if h(x-1,y) >= 0 
    {
      z := z + ord(h(x-1,y) == 0);
      x := x - 1;
    }

    else 
    {
      y := y + 1;
    }
  }
}