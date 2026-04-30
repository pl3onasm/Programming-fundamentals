/* file: prob16.dfy
   author: your name
   description: extra practice in Dafny, basic, prob16  
*/

method problem16(p:int, q:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires X >= 0 && (p == X + 3 || p == -X) && p * p + q == Y
ensures  r == X && r * r + s == Y
{
  // X and Y are specification constants and are not allowed
  // to appear in the body of this method.

  // implement yourself
   
}