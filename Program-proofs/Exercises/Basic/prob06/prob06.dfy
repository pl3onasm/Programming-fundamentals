/* file: prob06.dfy
   author: your name
   description: extra practice in Dafny, basic, prob06
*/

method problem06(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires 4 * x + 2 * y == 2 * X + 4 * Y && 2 * x - y == Y
ensures  r == X && s == Y - 3 * X
{
  // X and Y are specification constants and are not allowed 
  // to appear in the body of this method.
   
  // implement yourself
  
}