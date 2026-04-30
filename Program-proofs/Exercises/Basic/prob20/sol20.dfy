/* file: sol20.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob20
*/

const n:int

method problem20(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r >= n && (r == 2 * X + 2 * n || r == -2 * X)
{
  // P: x = X

  if (2 * x >= -n)
  {
      // x = X ∧ 2 * x + n ≥ 0
      //  (prepare r := 2 * x + 2 * n)
      // 2 * x + 2 * n = 2 * X + 2 * n ∧ 2 * x + 2 * n ≥ n
    r := 2 * x + 2 * n;
      // r = 2 * X + 2 * n ∧ r ≥ n
  }

  else 
  {
      // x = X ∧ 2 * x + n < 0
      //  (prepare r := -2 * x)
      // -2 * x = -2 * X ∧ -2 * x > -n
    r := -2 * x;
      // r = -2 * X ∧ r > n
  }

  // Collect branches:
  // Q: r ≥ n ∧ (r = 2 * X + 2 * n ∨ r = -2 * X)
}