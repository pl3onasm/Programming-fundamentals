/* file: prob04.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob04
   This is exercise 7.4 from the PC reader
*/

method problem04(x:nat) returns (y:int)
ensures y >= 0 && y * y <= x < (y + 1) * (y + 1)
{
  // Derive a command sequence that computes the integer square
  // root of x. This is the same problem as prob03, but now you 
  // you should use the heuristic of replacing an expression
  // by a variable to find a suitable invariant J and guard B.
  // Hint: you may find it useful to introduce a variable z that
  // represents the value of y + 1.
  
}