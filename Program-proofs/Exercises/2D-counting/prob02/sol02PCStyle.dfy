/*  file: sol02PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob02
    This is exercise 9.3 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
import opened MonotonicityProps

ghost function F(g:(int,int) -> int, x:int, y:int): int
requires Ordered2DInt(g, Desc, Asc)
{   
  if x <= 0 || y <= 0 
  then 0
  else if g(x-1,y-1) <= 0
       then F(g,x-1,y) + y
       else F(g,x,y-1)
}

method problem02(g:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(g, Desc, Asc)
ensures z == F(g, m ,n)
{
  var x, y := m, n;
  z := 0;
  
  while x > 0 && y > 0
  invariant z + F(g, x, y) == F(g, m, n)
  decreases x + y
  {
    if g(x-1,y-1) <= 0
    {
      z := z + y;
      x := x - 1;
    }

    else
    {
      y := y - 1;
    }
  }
}