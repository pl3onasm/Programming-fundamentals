/* file: sol08.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob08
*/

method problem08(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r > 0 && (r == 2 * X + 1 || r == -2 * X)
{
    // P: x = X
    
  if x >= 0 
  {
      // x = X ∧ x ≥ 0
      //  (prepare r := 2 * x + 1)
      // 2 * x + 1 = 2 * X + 1 ∧ 2 * x + 1 > 0
    r := 2 * x + 1;
      // r = 2 * X + 1 ∧ r > 0
  }

  else 
  {
      // x = X ∧ x < 0
      //  (prepare r := -2 * x)
      // -2 * x = -2 * X ∧ -2 * x > 0
    r := -2 * x;
      // r = -2 * X ∧ r > 0
  }  

  // Collect branches:
  // Q: r > 0 ∧ (r = 2 * X + 1 ∨ r = -2 * X)
}