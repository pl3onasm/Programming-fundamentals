/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 2
*/

method problem2(m:int, n:int, ghost X:int, ghost Y:int) returns (x:int, y:int)
  requires m + n == 3*X + 2*Y && 2*m + 3*n == 5*X + 7*Y
  ensures x == X && y == Y
{
    // m + n == 3*X + 2*Y && 2*m + 3*n == 5*X + 7*Y
    //    (isolate X in the first equality)
    // 3*m + n == 11*X && 2*m + 3*n == 5*X + 7*Y
  x := (3*m + n) / 11;
    // x == X && 2*m + 3*n == 5*X + 7*Y
    //    (substitute x for X in the second equality)
    // x == X && 2*m + 3*n == 5*x + 7*Y
    //    (isolate Y in the second equality)
    // x == X && (2*m + 3*n - 5*x)/7 == Y
  y := (2*m + 3*n - 5*x) / 7;
    // x == X && y == Y
}
