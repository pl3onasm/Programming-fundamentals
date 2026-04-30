/* file: prob07.dfy
   author: your name
   description: extra practice in Dafny, basic, prob07
*/

method problem07(a:int, b:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires a + b == X + Y && a * X == b * Y
ensures  a == X * X + X * Y
{
  // X and Y are specification constants and are not allowed 
  // to appear in the body of this method.
   
  // implement yourself
  
}