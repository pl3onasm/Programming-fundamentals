/* file: sol15PCStyle.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob15
   This is exercise 9.17 from the PC reader
   NOTE: This solution follows the PC-style proof method described
   in the general note on proof styles (see the README in the 
   Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(nat,nat) -> int, x:nat, y:nat,
                 p:nat, w:int): int
requires Ordered2DNat(h, Incr, Decr)
requires x <= p
requires y <= p
decreases (p - x) + (p - y)
{
  if x == p || y == p || x * x + y * y >= p then
    0
  else if h(x,y) < w then
    F(h, x + 1, y, p, w)
  else 
    F(h, x, y + 1, p, w) + ord(h(x,y) == w)
}

method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z:int)
requires Ordered2DNat(h, Incr, Decr)
ensures z == F(h, 0, 0, p, w)
{
  var x:nat, y:nat := 0, 0;
  z := 0;

  while x*x + y*y < p
    invariant 0 <= x <= p
    invariant 0 <= y <= p
    invariant z + F(h, x, y, p, w) == F(h, 0, 0, p, w)
    decreases (p - x) + (p - y)
  {
    if h(x,y) < w 
    {
      x := x + 1;
    } 

    else 
    {
      z := z + ord(h(x,y) == w);
      y := y + 1;
    }
  }
}
