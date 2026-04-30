/* file: prob10.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob10
*/

ghost function f(n:int):int
{
  if n < 0 then 0 else n - 2 * f(n - 7)
}

method problem10(n:int) returns (r:nat)
ensures  r == f(n)
{
  // Derive a command sequence S such that {P} S {Q}, 
  // where P is the precondition and Q is the postcondition.
  // Use the following loop invariant J:
  //   x + y * f(k) == f(n) 
}