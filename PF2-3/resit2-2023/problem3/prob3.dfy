/* file: prob3.dfy
   author: your name
   description: 2-3rd resit 2023, problem 3
*/

method problem3(n:int, m:int, X:int, Y: int) returns (p:int, q:int)
requires X >= 0 && (n == X + 3 || n == -X) && n*n + m == Y
ensures p == X && p*p + q == Y
{
  // X and Y are specification constants and are not 
  // allowed to appear in the body of this method.
   
  // implement yourself
}
