/* file: sol21.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob21
*/

method problem21(x:int, ghost X:int) returns (r:int, s:int)
requires x == X
ensures  s == 3 * r && s > r && (r == X + 1 || r == -X)
{
    // P: x = X

  if x >= 0 
  {
      // x = X ∧ x ≥ 0
      //   (prepare r := x + 1)
      // x + 1 = X + 1 ∧ x + 1 > 0
    r := x + 1;
      // r = X + 1 ∧ r > 0
  }

  else 
  {
      // x = X ∧ x < 0
      //   (prepare r := -x)
      // -x = -X ∧ -x > 0
    r := -x;
      // r = -X ∧ r > 0
  }

    // Collect branches:
    // (r = X + 1 ∨ r = -X) ∧ r > 0
    //    (use r > 0 ⇒ 3 * r > r)
    // 3 * r = 3 * r ∧ 3 * r > r ∧ (r = X + 1 ∨ r = -X) 
  s := 3 * r;
    // Q: s = 3 * r ∧ s > r ∧ (r = X + 1 ∨ r = -X)
}