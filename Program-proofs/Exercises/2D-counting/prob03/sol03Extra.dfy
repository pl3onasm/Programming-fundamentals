/*  file: sol03Extra.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    alternative solution to prob03
    This is exercise 9.4 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(int,int) -> int, x:int, y:int, m:int, n:int, w:int): int
requires Ordered2DInt(h, Decr, Asc)
decreases (m - x) + (n - y)
{   
  if x >= m || y >= n then 0
  else if h(x, y) > w then F(h, x + 1, y, m, n, w)
  else F(h, x, y + 1, m, n, w) + ord(h(x, y) == w)
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (z: int)
requires Ordered2DInt(h, Decr, Asc)
ensures z == F(h, 0, 0, m, n, w)
{
  var x, y := 0, 0;
  z := 0;
  
  while x < m && y < n
  invariant z + F(h, x, y, m, n, w) == F(h, 0, 0, m, n, w)
  decreases (m - x) + (n - y)
  {
    if h(x, y) > w
    {
      x := x + 1;
    }

    else
    {
      z := z + ord(h(x, y) == w);
      y := y + 1;
    }
  }
}