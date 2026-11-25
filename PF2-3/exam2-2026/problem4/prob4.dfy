/* file: prob4.dfy
   author: your name
   description: 2-3rd exam 2026, problem 4
*/

method problem4(a: int, b: int, c: int) returns (x: int, y: int, z: int)
  requires 2 <= a <= b
  ensures  0 <= x < 2 && 0 <= y < 3 && x + 2*y + 5*z == a + 2*b + 5*c
{
  x, y, z := a, b, c;
  
  while ???
    invariant ???
    decreases ???
  {
    if x >= 2 
    {
      x := x - 2;
      y := y + 1;
    }

    if y >= 3 
    {
      y := y - 3;
      z := z + 1;
      x := x + 1;
    }
  }
}
