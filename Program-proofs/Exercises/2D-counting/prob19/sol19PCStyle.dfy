/*  file: sol19PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    solution to prob19
    This is exercise 9.21 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function Gap(h:(nat,nat) -> int, x:nat, y:nat, c:int): nat
{
  if 0 < x && h(x-1,y) < c then c - h(x-1,y) else 0
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat, c:int): nat
requires Ordered2DNat(h, Asc, Incr)
requires x <= n
decreases x, Gap(h,x,y,c)
{
  if x == 0 then
    0
  else if h(x-1,y) < c then
    F(h,x,y+1,n,c)
  else 
    ord(h(x-1,y) == c) + F(h,x-1,y,n,c)
}

method problem19(h:(nat,nat) -> int, n:nat, c:int)
returns (z:int)
requires Ordered2DNat(h, Asc, Incr)
requires c < h(n,0)
ensures z == F(h,n,0,n,c)
{
  var x:nat := n;
  var y:nat := 0;
  z := 0;

  while x > 0
    invariant x <= n
    invariant z + F(h,x,y,n,c) == F(h,n,0,n,c)
    decreases x, Gap(h,x,y,c)
  {
    if h(x-1,y) < c 
    {
      y := y + 1;
    } 
    
    else 
    {
      z := z + ord(h(x-1,y) == c);
      x := x - 1;
    }
  }
}