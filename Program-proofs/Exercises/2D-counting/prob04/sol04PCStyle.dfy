/*  file: sol04PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob04
    This is exercise 9.5 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport

ghost function F(g:(int,int) -> int, x:nat, y:nat, m:nat): int
requires Ordered2DInt(g, Incr, Incr)
decreases (m - x) + y
{   
  if x >= m || y <= 0 then 0
  else if g(x, y - 1) < y - 1 then F(g, x + 1, y, m)
  else F(g, x, y - 1, m) + ord(g(x, y - 1) == y - 1)
}

method problem04(g:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(g, Incr, Incr)
ensures z == F(g, 0, n, m)
{
  var x, y := 0, n;
  z := 0;

  while x < m && y > 0
  invariant z + F(g,x,y,m) == F(g,0,n,m)
  decreases (m - x) + y
  {   
    if g(x, y - 1) < y - 1
    {   
      x := x + 1;
    }

    else
    { 
      z := z + ord(g(x, y - 1) == y - 1);
      y := y - 1;
    }
  }
}

