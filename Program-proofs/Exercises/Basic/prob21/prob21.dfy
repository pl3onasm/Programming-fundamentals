/* file: prob21.dfy
   author: your name
   description: extra practice in Dafny, basic, prob21  
*/

method problem21(x:int, ghost X:int) returns (r:int, s:int)
requires x == X
ensures  s == 3 * r && s > r && (r == X + 1 || r == -X)
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}