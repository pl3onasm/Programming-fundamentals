/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 4
*/

method problem4(a: nat, b: nat, c: nat) returns (x: nat, y: nat, z: nat)
  ensures x <= y <= z
  ensures x + y + z == a + b + c
{
  x,y,z := a,b,c;
  while x > y || y > z
    invariant x + y + z == a + b + c
    decreases (a + b + c) - (z - x)   
  {
    if x > y {
      x := x - 1;
      y := y + 1;
    }
    if y > z {
      y := y - 1;
      z := z + 1;
    }
  }
}

/* Each iteration of the loop increases the distance between x and z by 
   at least 1, because either x decreases by 1 (if x > y) or z increases 
   by 1 (if y > z).
   Since the distance between x and z is initially at most a + b + c,
   we naturally use (a + b + c) - (z - x) as a decreasing measure for
   the loop which is always non-negative.
*/