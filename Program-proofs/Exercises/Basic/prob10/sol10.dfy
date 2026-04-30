/* file: sol10.dfy
   author: David De Potter
   description: extra practice in Dafny, basic,
   solution to prob10
*/

method problem10(i:int, k:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires i == X && k == Y && X >= Y
ensures  s >= 0 && ((r == X + Y && s == X) || (r == Y - X && s == -Y))
{
    // P: i = X ∧ k = Y ∧ X ≥ Y

  if k >= 0
  {
      // i = X ∧ k = Y ∧ k ≥ 0 ∧ X ≥ Y
      //   (prepare r := i + k; s := i)
      // i + k = X + Y ∧ i = X ∧ k ≥ 0 ∧ X ≥ Y
    r := i + k;
    s := i;
      //   (s = i = X ∧ X ≥ Y ∧ Y = k ≥ 0 ⇒ s ≥ 0)
      // r = X + Y ∧ s = X ∧ s ≥ 0
  }

  else 
  {
      // i = X ∧ k = Y ∧ k < 0 ∧ X ≥ Y
      //   (prepare r := k - i; s := -k)
      // k - i = Y - X ∧ -k = -Y ∧ -k ≥ 0 ∧ X ≥ Y
    r := k - i;
    s := -k;
      // r = Y - X ∧ s = -Y ∧ s ≥ 0
  }

  // Collect branches:
  // Q: s ≥ 0 ∧ ((r = X + Y ∧ s = X) ∨ (r = Y - X ∧ s = -Y))
  
}