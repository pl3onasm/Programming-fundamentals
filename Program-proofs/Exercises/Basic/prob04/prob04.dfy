/* file: prob04.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, prob04
   This is exercise 5.1d from the PC reader
*/

method problem04(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires x == X + Y && y == 2 * X - 7
ensures  r == X + Y && s == Y
{
  // X and Y are specification constants and are not allowed 
  // to appear in the body of this method.
   
  // implement yourself
  
}