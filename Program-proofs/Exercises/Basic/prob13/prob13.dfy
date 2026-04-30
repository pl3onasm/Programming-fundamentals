/* file: prob13.dfy
   author: your name
   description: extra practice in Dafny, basic, prob13  
*/

method problem13(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires X >= 0 && (x - 2 == X || x == -X) && x * x + y == Y
ensures  r == X && r * r + s == Y
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
  
}