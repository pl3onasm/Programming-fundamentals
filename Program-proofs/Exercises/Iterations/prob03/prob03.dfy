/* file: prob03.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob03
   This is exercise 6.5 from the PC reader
*/

ghost function f(y:int, z:int): int
{
  if y <= 0 then z else 10 * f(y/10, z) + y % 10
}

method problem03(y:int, z:int) returns (r:int)
ensures r == f(y, z)
{
  // Derive a command sequence that computes f(y, z) using iteration, 
  // and prove that it is correct. You should use the following 
  // loop invariant J:     m * f(y,z) + n = Z
  // You will likely need to use active finalization.
  
}