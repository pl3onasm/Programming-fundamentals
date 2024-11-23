/* file: prob3.dfy
   author: your name
   description: 2-3rd exam 2024, problem 3
*/

method problem3(a: int, n:int, ghost X: int) returns (b:int)
requires a == 2*X - n || a == 3*n - 2*X + 1
ensures b == X
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.
  //
  // implement yourself.

}
