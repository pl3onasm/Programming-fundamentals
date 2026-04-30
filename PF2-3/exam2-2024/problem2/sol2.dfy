/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 2
*/

method problem2(a:int, b:int, ghost X:int, ghost Y:int) returns (c:int, d : int)
requires a == 2*X - 5*Y && b == X + 2*Y
ensures c == X && d == Y
{
    // a == 2*X - 5*Y && b == X + 2*Y
    //    (isolate Y by subracting 2*b from a)
    // a - 2*b == -9*Y && b == X + 2*Y
    //    (prepare d := (2*b - a)/9)
    // (2*b - a) / 9 == Y && b == X + 2*Y

  d := (2*b - a)/9;

    // d == Y && b == X + 2*Y
    //    (prepare c := b - 2*d)
    // d == Y && b - 2*d == X

  c := b - 2*d;
  
    // d == Y && c == X
}
