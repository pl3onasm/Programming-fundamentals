/* file: prob03.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob03
   This is exercise 7.3 from the PC reader
*/

method problem03(x:nat) returns (y:int)
ensures y >= 0 && y * y <= x < (y + 1) * (y + 1)
{
  // Derive a command sequence that computes the integer square
  // root of x. Use the heuristic of isolating a conjunct in the
  // postcondition to find a suitable invariant J and guard B.
  
}