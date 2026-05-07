/* file: prob05.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob05
   This is exercise 7.5 from the PC reader
*/

method problem05(x:nat, y:nat) returns (q:nat, r:nat)
requires y > 0
ensures  x == q * y + r && 0 <= r < y
{
  // Derive a command sequence that computes integral division of x by y.
  // It should not use multiplication, division or modulus. You should
  // use the heuristic of isolating a conjunct in the postcondition to
  // find a suitable invariant J and guard B.
  
}