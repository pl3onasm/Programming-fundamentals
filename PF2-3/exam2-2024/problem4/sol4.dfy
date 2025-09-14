/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 4
*/

method problem4(a: nat, b:nat) 
requires a >= b
{
  var x := a;
  var y := b;
  while x != y 
  invariant x >= y 
  decreases x - y
  {
    y := y + 1;
    x := x - x % y;
  }
  assert x == y;
}


