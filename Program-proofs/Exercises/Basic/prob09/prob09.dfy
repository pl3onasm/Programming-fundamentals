/* file: prob09.dfy
   author: your name
   description: extra practice in Dafny, basic, prob09
   Based on exercise 5.16b from the PC reader
*/

method problem09(x:int, ghost X:int) returns (r:int)
requires x == 2 * X + 1 || x == -2 * X
ensures  r == X
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method
   
  // implement yourself
  
}