/* file: sol3.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 3
*/

method problem3(n:int, X:int) returns (r:int)
requires X >= 0 && (n == 2 * X + 5 || 2 * n == 9 - X)
ensures r == X
{
  if (2*n - 9 <= 0) {
      // 2*n == 9 - X
      // 9 - 2*n == X
    r := 9 - 2*n;
      // r == X
  } else {
      // n == 2*X + 5
      // (n - 5)/2 == X
    r := (n - 5) / 2;
      // r == X
  }
}