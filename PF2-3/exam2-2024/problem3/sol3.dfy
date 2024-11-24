/* file: sol3.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 3
*/

method problem3(a: int, n:int, ghost X: int) returns (b:int)
requires a == 2*X - n || a == 3*n - 2*X + 1
ensures b == X
{
  if (a + n) % 2 == 0 {
    // a + n == 2*X
    //    (prepare b := (a + n) / 2)
    // (a + n) / 2 == X
    b := (a + n) / 2;
    assert (b == X);
  } else {
    // a + n == 2*(2*n - X) + 1
    // -3*n + a - 1 == -2*X;
    //    (prepare b := (3*n - a + 1) / 2)
    // (3*n - a + 1) / 2 == X
    b := (3*n - a + 1) / 2;
    assert (b == X);
  }
}

