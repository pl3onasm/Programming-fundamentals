/* file: sol01.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations,
   solution to prob01
   This is exercise 6.2 from the PC reader
*/

method problem01(a:int, b:int, ghost X:int) returns (r:int)
requires a * b == X && b >= 0
ensures  r == X
{
  var x, y := a, b;
  r := 0;
  while y != 0
    invariant x * y + r == X && y >= 0
  {
    r := r + x * (y % 2);
    x := 2 * x;
    y := y / 2;
  }
  return r;
}