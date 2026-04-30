/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 4
*/

method problem4(a: nat, b: nat, c: nat) returns (x: nat, y: nat, z: nat)
  ensures x <= y <= z
  ensures x + y + z == a + b + c
{
  x, y, z := a, b, c;

  while x > y || y > z
    invariant x + y + z == a + b + c
    decreases (a + b + c) - (z - x)   
  {
    if x > y 
    {
      x := x - 1;
      y := y + 1;
    }
    
    if y > z 
    {
      y := y - 1;
      z := z + 1;
    }
  }
}
