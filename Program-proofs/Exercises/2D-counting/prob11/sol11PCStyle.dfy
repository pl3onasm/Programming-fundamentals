/*  file: sol11PCStyle.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting, 
    solution to prob11, with annotations
    This is exercise 9.13 from the PC reader on coincidence counting
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(a: array<int>, b: array<int>, x: int, y: int): int
reads a, b
requires OrderedArray(a, Incr) && OrderedArray(b, Incr)
requires 0 <= x <= a.Length && 0 <= y <= b.Length
decreases a.Length - x + b.Length - y
{
  if x >= a.Length || y >= b.Length 
  then 0
  else if a[x] < b[y] 
       then F(a,b,x+1,y)
       else F(a,b,x,y+1) + ord(a[x] == b[y])
}
    
method problem11(a: array<int>, b: array<int>)
returns (z: int)
requires OrderedArray(a, Incr) && OrderedArray(b, Incr)
ensures z == F(a,b,0,0)
{ 
  var m, n := a.Length, b.Length;
  var x, y := 0, 0;
  z := 0;

  while x < m && y < n
  invariant 0 <= x <= m && 0 <= y <= n
  invariant z + F(a,b,x,y) == F(a,b,0,0)
  decreases m - x + n - y
  {
    if a[x] < b[y]
    {
      x := x + 1;
    }

    else
    {
      z := z + ord(a[x] == b[y]);
      y := y + 1;
    }
  }
}