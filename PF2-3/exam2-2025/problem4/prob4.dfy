/* file: prob4.dfy
   author: your name
   description: 2-3rd exam 2025, problem 4
*/

method problem4(a: nat, b: nat, c: nat) returns (x: nat, y: nat, z: nat)
  ensures x <= y <= z
  ensures x + y + z == a + b + c
{
  x,y,z := a,b,c;
  while ???
    invariant ??? == a + b + c
    decreases ???
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
