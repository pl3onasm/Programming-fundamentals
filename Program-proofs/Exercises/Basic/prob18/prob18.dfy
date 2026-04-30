/* file: prob18.dfy
   author: your name
   description: extra practice in Dafny, basic, prob18  
*/

method problem18(n:int, ghost X:int) returns (r:int)
requires X >= 0 && (3 * n == 2 - X || n == X + 2)
ensures  r == X
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}