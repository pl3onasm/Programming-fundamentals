/*  file: sol18PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    solution to prob18
    This is exercise 9.20 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport 

ghost function F(f:(nat,nat) -> int, x:nat, y:nat, c:int): int
requires Ordered2DNat(f, Asc, Asc)
requires y <= x
decreases x - y
{
  if y >= x then 0
  else if f(x-1,y) > c
       then F(f,x-1,y,c)
       else F(f,x,y+1,c) + ord(f(x-1,y) == c)
}

method problem18(f:(nat,nat) -> int, c:int, d:nat)
returns (z:int)
requires Ordered2DNat(f, Asc, Asc)
ensures z == F(f,d+1,0,c)
{
  var x:nat, y:nat := d + 1, 0;
  z := 0;

  while y < x
  invariant y <= x
  invariant z + F(f,x,y,c) == F(f,d+1,0,c)
  decreases x - y
  {
    if f(x-1,y) > c
    {
      x := x - 1;
    }

    else
    {
      z := z + ord(f(x-1,y) == c);
      y := y + 1;
    }
  }
}
