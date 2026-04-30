/* file: prob01.dfy
   author: your name
   description: extra practice in Dafny, basic, prob01
   This is exercise 5.1a from the PC reader
*/

method problem01(x:int, ghost X:int) returns (r:int)
requires x == 5 * X - 7 
ensures  r == X
{
  // X is a specification constant and is not allowed 
  // to appear in the body of this method.
   
  // implement yourself
  
}