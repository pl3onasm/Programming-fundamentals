/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 2
*/

method problem2(n:int, t:int, X:int, Y:int) returns (r:int, s:int)
requires n == Y + 1 && t == X + 2*Y
ensures r == X && s == Y
{
    // n == Y + 1 && t == X + 2*Y
    //     (isolate X by subtracting 2*n from t)
    // n == Y + 1 && t - 2*n == X - 2
    //     (prepare r := t - 2*n + 2)
    // n == Y + 1 && t - 2*n + 2 == X

  r := t - 2*n + 2;

    // n == Y + 1 && r == X
    //     (prepare s := n - 1)
    // n - 1 == Y && r == X

  s := n - 1;
  
    // s == Y && r == X
}