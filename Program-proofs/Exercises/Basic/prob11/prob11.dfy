/* file: prob11.dfy
   author: your name
   description: extra practice in Dafny, basic, prob11  
   This is exercise 5.13b from the PC reader
*/

method problem11(x :int, y:int, ghost Z:int) returns (r:int, s:int)
requires x + y == Z
ensures  r + s == Z && r * s < 0
{
  // Z is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
  
}