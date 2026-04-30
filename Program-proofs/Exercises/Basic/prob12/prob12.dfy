/* file: prob12.dfy
   author: your name
   description: extra practice in Dafny, basic, prob12  
   This is exercise 5.14 from the PC reader
*/

method problem12(x :int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires X > Y && ((x == X && y == -2 * X + Y) || (x == Y && y == X - 2 * Y))
ensures  r == X && s == Y
{
  // X and Y are specification constants and are not allowed
  // to appear in the body of this method.

  // implement yourself
  
}