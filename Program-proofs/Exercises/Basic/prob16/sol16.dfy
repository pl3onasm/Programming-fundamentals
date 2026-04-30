/* file: sol16.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob16  
*/

method problem16(p:int, q:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires X >= 0 && (p == X + 3 || p == -X) && p * p + q == Y
ensures  r == X && r * r + s == Y
{
  // P: X ≥ 0 ∧ (p = X + 3 ∨ p = -X) ∧ p * p + q = Y
  //   ( case split on the second conjunct )
  
  if p > 0 
  {
      // X ≥ 0 ∧ p = X + 3 ∧ p * p + q = Y
      //   (prepare r := p - 3)
      // X ≥ 0 ∧ p - 3 = X ∧ (p - 3) * (p - 3) + 6 * p - 9 + q = Y
    r := p - 3;
      // r ≥ 0 ∧ r = X ∧ r * r + 6 * p - 9 + q = Y
    s := 6 * p - 9 + q;
      // r = X ∧ r * r + s = Y
  }

  else
  {
      // X ≥ 0 ∧ p = -X ∧ p * p + q = Y
      //   (prepare r := -p)
      // X ≥ 0 ∧ -p = X ∧ (-p) * (-p) + q = Y
    r := -p;
      // r ≥ 0 ∧ r = X ∧ r * r + q = Y
    s := q;
      // r = X ∧ r * r + s = Y
  }

  // Collect branches:
  // Q: r = X ∧ r * r + s = Y
}