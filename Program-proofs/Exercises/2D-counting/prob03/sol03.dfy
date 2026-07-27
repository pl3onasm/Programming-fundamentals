/*  file: sol03.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob03
    This is exercise 9.4 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(int,int) -> int, x:int, y:int, w:int): int
requires Ordered2DInt(h, Decr, Asc)
{  
  if x <= 0 || y <= 0 then 0
  else if h(x - 1, y - 1) < w then F(h, x - 1, y, w)
  else F(h, x, y - 1, w) + ord(h(x - 1, y - 1) == w)
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (z: int)
requires Ordered2DInt(h, Decr, Asc)
ensures z == F(h, m ,n, w)
{
  var x, y := m, n;
  z := 0;

  while x > 0 && y > 0
  invariant z + F(h, x, y, w) == F(h, m, n, w)
  decreases x + y
  {
    if h(x - 1, y - 1) < w
    {
      x := x - 1;
    }

    else
    {
      z := z + ord(h(x - 1, y - 1) == w);
      y := y - 1;
    }
  }
}