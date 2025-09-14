/* file: prob2.dfy
   author: your name
   description: 2-3rd resit 2023, problem 2
*/

method problem2(m:int, n:int, X:int, Y:int) returns (x:int, y:int)
requires 3*m + 2*n == 2*X + Y && 2*m == X + Y
ensures x==X && y == Y
{
  // X and Y are specification constants and are 
  // not allowed to appear in the body of this method.
  
  // implement yourself
  
}
