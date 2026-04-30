/* file: sol11.dfy
   author: David De Potter
   description: extra practice in Dafny, basic,
   solution to prob11
*/

method problem11(x :int, y:int, ghost Z:int) returns (r:int, s:int)
requires x + y == Z
ensures  r + s == Z && r * s < 0
{
  // P: x + y == Z
  
  if x + y >= 0
  {
      // x + y = Z ∧ x + y ≥ 0
      //  (prepare r := x + y + 1; s := -1)
      // x + y + 1 = Z + 1 ∧ (x + y + 1) * (-1) = -(x + y) - 1 < 0
    r := x + y + 1;
    s := -1;
      // r + s = Z ∧ r * s < 0
  }

  else 
  {
      // x + y = Z ∧ x + y < 0
      //  (prepare r := x + y - 1; s := 1)
      // x + y - 1 = Z - 1 ∧ (x + y - 1) * 1 = x + y - 1 < 0
    r := x + y - 1;
    s := 1;
      // r + s = Z ∧ r * s < 0
  }
  
  // Collect branches:
  // Q: r + s = Z ∧ r * s < 0
}