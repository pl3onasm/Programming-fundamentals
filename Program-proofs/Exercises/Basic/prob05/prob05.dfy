/* file: prob05.dfy
   author: your name
   description: extra practice in Dafny, basic, prob05
   This is exercise 5.1e from the PC reader
*/

method problem05(x:int, ghost X:int) returns (r:int)
requires 7 * X - 2 <= x < 7 * X + 5 
ensures  r == X
{
  // X is a specification constant and is not allowed 
  // to appear in the body of this method.
   
  // implement yourself
  
}