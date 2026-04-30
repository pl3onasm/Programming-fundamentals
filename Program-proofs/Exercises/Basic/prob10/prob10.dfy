/* file: prob10.dfy
   author: your name
   description: extra practice in Dafny, basic, prob10
   This is exercise 5.12 from the PC reader
*/

method problem10(i :int, k:int, ghost X:int, ghost Y: int) returns (r:int, s:int)
requires i == X && k == Y && X >= Y
ensures  s >= 0 && ((r == X + Y && s == X) || (r == Y - X && s == -Y))
{
  // X and Y are specification constants and are not allowed
  // to appear in the body of this method.
    
  // implement yourself
  
}