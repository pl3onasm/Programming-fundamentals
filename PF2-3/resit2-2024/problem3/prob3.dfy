/* file: prob3.dfy
   author: your name
   description: 2-3rd resit 2024, problem 3
*/

method problem3(n:int, ghost X: int) returns (r:int)
requires n == X
ensures r >= 0 && (r + X == 0 || 3*r <= X + 1 < 3*(r + 1))
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.
  //
  // implement yourself.
  
}
