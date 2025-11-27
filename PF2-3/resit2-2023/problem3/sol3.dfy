/* file: sol3.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 3
*/

method problem3(n:int, m:int, X:int, Y: int) returns (p:int, q:int)
requires X >= 0 && (n == X + 3 || n == -X) && n*n + m == Y
ensures p == X && p*p + q == Y
{
  if (n > 0) {
      // n == X + 3 && n*n + m == Y
      // n - 3 == X && (n - 3)*(n - 3) + 6*n - 9 + m == Y
      // n - 3 == X && (n - 3)*(n - 3) + 6*(n - 3) + 9 + m == Y
    p := n - 3;
      // p == X && p*p + 6*p + 9 + m == Y
    q := 6*p + 9 + m;
      // p == X && p*p + q == Y
  } else {
      // n == -X && n*n + m == Y
      // -n == X && (-n)*(-n) + m == Y
    p := -n;
      // p == X && p*p + m == Y
    q := m;
      // p == X && p*p + q == Y
  }
    // collect branches
  assert p == X && p*p + q == Y;
}
