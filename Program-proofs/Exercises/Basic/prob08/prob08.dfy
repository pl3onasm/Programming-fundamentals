/* file: prob08.dfy
   author: your name
   description: extra practice in Dafny, basic, prob08
*/

method problem08(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r > 0 && (r == 2 * X + 1 || r == -2 * X)
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method
   
  // implement yourself
  
}