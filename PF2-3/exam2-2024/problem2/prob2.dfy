/* file: prob2.dfy
   author: your name
   description: 2-3rd exam 2024, problem 2
*/

method problem2(a:int, b:int, ghost X:int, ghost Y:int) returns (c:int, d : int)
requires a == 2*X - 5*Y && b == X + 2*Y
ensures c == X && d == Y
{
  // X and Y are specification constants and are not allowed 
  // to appear in the body of this method.
  // 
  // implement yourself
  
}
