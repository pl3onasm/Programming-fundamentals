/* file: prob06.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob06
   This is exercise 7.6 from the PC reader
*/

method problem06(x:nat, y:nat) returns (q:nat, r:nat)
requires y > 0
ensures  x == q * y + r && 0 <= r < y
{
  // Derive a command sequence that computes integral division of x by y.
  // In contrast to prob05, you may now also use multiplications of the 
  // form 2 * p and divisions of the form p / 2. The intention is to
  // speed up the method of repeated subtraction from prob05 by first
  // finding a power-of-2 multiple of y, call it z, that is larger
  // than x, and then working back down from z to y by repeatedly
  // halving z while updating the quotient and remainder accordingly.
  //
  // You will need two loops: the first one to find z, and the second
  // one to work back down from z to y. The invariants will now also 
  // need to keep track of the value of z.
  //
  // You should use the heuristic of replacing an expression by a variable
  // to find suitable invariants J and guards B for both loops. 
}