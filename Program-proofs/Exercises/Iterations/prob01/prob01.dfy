/* file: prob01.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob01
   This is exercise 6.2 from the PC reader
*/

method problem01(a:int, b:int, ghost X:int) returns (r:int)
requires a * b == X && b >= 0
ensures  r == X
{
  // X is a specification constant and is not allowed 
  // to appear in the body of this method.
   
  // Design a command S such that {P} S {Q} only using
  // addition, multiplication by 2 and division by 2 with
  // remainder. Use the invariant a * b + r == X && b >= 0
  
}