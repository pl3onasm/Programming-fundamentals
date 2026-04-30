/* file: sol15.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob15  
*/

method problem15(x:int, n:int, ghost X:int) returns (r:int)
requires X >= 0 && (n == 2 * X - 3 || 4 * X + n == 0)
ensures  r >= 0 && r == X
{
  // P: X ≥ 0 ∧ (n = 2 * X - 3 ∨ 4 * X + n = 0)
  //   (regroup)
  // X ≥ 0 ∧ (n = 2 * X - 3 ∨ n = -4 * X)

  if n % 2 == 0
  {
      //   (first disjunct is false)
      // X ≥ 0 ∧ n = -4 * X
      //   (prepare r := -n / 4)
      // -n / 4 = X ∧ -n / 4 ≥ 0
    r := -n / 4;
      // r = X ∧ r ≥ 0
  }

  else
  {   
      //   (second disjunct is false)
      // X ≥ 0 ∧ n = 2 * X - 3
      //   (prepare r := (n + 3) / 2)
      // (n + 3) / 2 = X ∧ (n + 3) / 2 ≥ 0
    r := (n + 3) / 2;
      // r = X ∧ r ≥ 0
  }

  // Collect branches:
  // Q: r ≥ 0 ∧ r = X
  
}