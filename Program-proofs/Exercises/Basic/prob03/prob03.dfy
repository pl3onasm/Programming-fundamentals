/* file: prob03.dfy
   author: your name
   description: extra practice in Dafny, basic, prob03
   This is exercise 5.1c from the PC reader
*/

method problem03(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires x == X + 3 * Y - 1 && y == Y
ensures  r == X && s == Y
{
  // X and Y are specification constants and are not allowed 
  // to appear in the body of this method.
   
  // implement yourself
  
}