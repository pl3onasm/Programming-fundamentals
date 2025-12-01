/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 4
*/

method problem4(a:nat, b:nat) returns (x:nat)
  requires a > 0 && b > 0
{
  var y:nat;
  x := a;
  y := b;

  while x != y 
    invariant x > 0 && y > 0
    decreases x + y
  {
    if x > y 
    {
      x := x - y;
    } 
    else 
    {
      y := y - x;
    }
  }
}