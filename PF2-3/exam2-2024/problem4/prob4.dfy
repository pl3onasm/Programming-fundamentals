/* file: prob4.dfy
   author: your name
   description: 2-3rd exam 2024, problem 4
*/

method problem4(a: nat, b:nat) 
requires a >= b
{
  var x := a;
  var y := b;
  while x != y 
  invariant ??   // choose a suitable invariant
  decreases ??   // choose a suitable variant function
  {
    y := y + 1;
    x := x - x % y;
  }
  assert x == y;
}
