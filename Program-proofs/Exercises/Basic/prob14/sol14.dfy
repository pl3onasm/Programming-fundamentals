/* file: sol14.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob14
*/

const n:int

method problem14(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r >= n && (r == 2 * X - n || r == 3 * n - 2 * X + 1)
{
  // P: x = X

  if x >= n 
  {
      // x = X ∧ x ≥ n
      //  (prepare r := 2 * x - n)
      // 2 * x - n = 2 * X - n ∧ 2 * x - n ≥ n
    r := 2 * x - n;
      // r = 2 * X - n ∧ r ≥ n
  }

  else 
  {
      // x = X ∧ x < n
      //  (prepare r := 3 * n - 2 * x + 1)
      // 3 * n - 2 * x + 1 = 3 * n - 2 * X + 1 ∧ - 2 * x > - 2 * n
      // 3 * n - 2 * x + 1 = 3 * n - 2 * X + 1 ∧ 3 * n - 2 * x + 1 > n 
    r := 3 * n - 2 * x + 1;
      // r = 3 * n - 2 * X + 1 ∧ r > n
  }

  // Collect branches:
  // Q: r ≥ n ∧ (r = 2 * X - n ∨ r = 3 * n - 2 * X + 1)
   
}