/*  file: sol07PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob07
    This is exercise 9.8 from the PC reader
    NOTE: This solution follows the PC-style proof method described 
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"

import opened MonotonicityProps

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat): int
requires Ordered2DNat(h, Asc, Asc)
decreases n - x + y
{
  if x >= n || y == 0 then 0
  else if h(x, y - 1) <= 0 
       then F(h, x + 1, y, n)
       else if x + y <= n
            then F(h, x, y - 1, n) + n - x - y + 1
            else F(h, x, y - 1, n)
}

method problem07(h:(nat,nat) -> int, n:nat) 
returns (z: int)
requires Ordered2DNat(h, Asc, Asc)
ensures z == F(h,0,n,n)
{
  var x, y := 0, n;
  z := 0;

  while x < n && y > 0
  invariant z + F(h,x,y,n) == F(h,0,n,n)
  decreases n - x + y
  {   
    if h(x, y - 1) <= 0 
    {
      x := x + 1;
    }

    else 
    {
      if x + y <= n
      {
        z := z + n - x - y + 1;
      }

      y := y - 1;
    }
  }
}