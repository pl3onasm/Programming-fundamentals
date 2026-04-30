/* file: sol13.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob13
*/

method problem13(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires X >= 0 && (x - 2 == X || x == -X) && x * x + y == Y
ensures  r == X && r * r + s == Y
{
  // P: X ≥ 0 ∧ (x - 2 = X ∨ x = -X) ∧ x * x + y = Y
  // (x - 2 = X ≥ 0 ∨ x = -X ≥ 0) ∧ x * x + y = Y

  if x >= 2
  {
      //   (second disjunct is false)
      // x - 2 = X ≥ 0 ∧ x * x + y = Y
      //   (prepare r := x - 2 )
      // x - 2 = X ∧ (x - 2 + 2) * (x - 2 + 2) + y = Y
    r := x - 2;
      // r = X ∧ (r + 2) * (r + 2) + y = Y
      // r = X ∧ r * r + 4 * r + 4 + y = Y
    s := 4 * r + 4 + y;
      // r = X ∧ r * r + s = Y
  }

  else 
  {
      //   (first disjunct is false)
      // x = -X ≥ 0 ∧ x * x + y = Y
      //   (prepare r := -x)
      // -x = X ∧ (-x) * (-x) + y = Y
    r := -x;
      // r = X ∧ r * r + y = Y
    s := y;
      // r = X ∧ r * r + s = Y
  }
  
  // Collect branches:
  // Q: r = X ∧ r * r + s = Y
}