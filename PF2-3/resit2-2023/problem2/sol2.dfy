/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 2
*/

method problem2(m:int, n:int, X:int, Y:int) returns (x:int, y:int)
requires 3*m + 2*n == 2*X + Y && 2*m == X + Y
ensures x == X && y == Y
{
    // 3*m + 2*n - 2*m == 2*X + Y - X - Y
    // m + 2*n == X
  x := m + 2*n;
    // x == X && 2*m == X + Y
    // x == X && 2*m - x == Y
  y := 2*m - x;
    // x == X && y == Y
}
