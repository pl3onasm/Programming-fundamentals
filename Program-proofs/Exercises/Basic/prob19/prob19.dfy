/* file: prob19.dfy
   author: your name
   description: extra practice in Dafny, basic, prob19  
*/

method problem19(n:int, ghost X:int) returns (r:int)
requires n == 4 * X + 7 || n == 6 * X + 4
ensures  r == X
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}