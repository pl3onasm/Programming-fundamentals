/*  file: sol17PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting, 
    solution to prob17
    This is exercise 9.19 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport 

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, z:int, m:nat, 
                 w:int): int
requires  Ordered2DNat(h, Asc, Asc)
requires  x <= m
decreases m - x + y
{
  if x >= m || y == 0 then z
  else if h(x,y-1) <= w
       then F(h, x+1, y, z, m, w)
       else F(h, x, y-1, minimum(z, x + (y-1)), m, w)
}

method problem17(h:(nat,nat) -> int, m:nat, n:nat, w:int)
returns  (z:int)
requires Ordered2DNat(h, Asc, Asc)
ensures  z == F(h,0,n,m+n,m,w)
{
  var x:nat, y:nat := 0, n;
  z := m + n;

  while x < m && 0 < y
  invariant x <= m
  invariant y <= n
  invariant F(h,x,y,z,m,w) == F(h,0,n,m+n,m,w)
  decreases (m - x) + y
  {
    if h(x,y-1) <= w
    {
      x := x + 1;
    }

    else
    {
      z := minimum(z, x + y - 1);
      y := y - 1;
    }
  }
}