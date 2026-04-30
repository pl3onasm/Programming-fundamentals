/* file: prob15.dfy
   author: your name
   description: extra practice in Dafny, basic, prob15  
*/

method problem15(x:int, n:int, ghost X:int) returns (r:int)
requires X >= 0 && (n == 2 * X - 3 || 4 * X + n == 0)
ensures  r >= 0 && r == X
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}