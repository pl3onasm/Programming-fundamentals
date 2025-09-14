/* file: prob2.dfy
   author: your name
   description: 2-3rd resit 2024, problem 2
*/

method problem2(m:int, n:int, ghost X:int, ghost Y:int) returns (x:int, y:int)
  requires m + n == 3*X + 2*Y && 2*m + 3*n == 5*X + 7*Y
  ensures x==X && y == Y
{
  // X and Y are specification constants and are not allowed 
  // to appear in the body of this method.
  // 
  // implement yourself
  
}

