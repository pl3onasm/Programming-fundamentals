/*  file: sol05PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob05
    This is exercise 9.6 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"

import opened MonotonicityProps

ghost function F(h:(int,int) -> int, x:nat, y:nat, c:int): int
requires Ordered2DInt(h, Asc, Asc)
decreases y - x
{   
  if x >= y then 0
  else if h(x, y - 1) <= c then F(h, x + 1, y, c) + (y - x)
  else F(h, x, y - 1, c)
}

method problem05(h:(int,int) -> int, n:nat, c:int) 
returns (z: int)
requires Ordered2DInt(h, Asc, Asc)
ensures z == F(h, 0, n, c)
{
  var x:nat, y:nat := 0, n;
  z := 0;

  while x < y
  invariant z + F(h,x,y,c) == F(h,0,n,c)
  decreases y - x
  {   
    if h(x, y - 1) <= c
    {
      z := z + (y - x);
      x := x + 1;
    }
    
    else
    { 
      y := y - 1;
    }
  }
}