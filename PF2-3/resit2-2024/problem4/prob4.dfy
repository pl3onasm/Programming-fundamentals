/* file: prob4.dfy
   author: your name
   description: 2-3rd resit 2024, problem 4
*/

method problem4(a:nat, b:nat) returns (x:nat)
requires a > 0 && b > 0
{
  var y:nat;
  x := a;
  y := b;
  
  while x != y
  // find a suitable invariant and decreases clause such 
  // that Dafny is able to prove termination
  invariant ??
  decreases ??
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
