/* file: sol03Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob03, with annotations
   This is exercise 7.3 from the PC reader
*/

method problem03(x:nat) returns (y:int)
ensures y >= 0 && y * y <= x < (y + 1) * (y + 1)
{
    // Initialization to establish invariant J
    // P: True
    //   ( arithmetic; x is a natural number, so x ≥ 0 )
    // 0 ≥ 0 ∧ 0 * 0 ≤ x 
  y := 0;
    // J: y ≥ 0 ∧ y * y ≤ x 

  while (y + 1) * (y + 1) <= x
    invariant y >= 0 && y * y <= x
    decreases x - y     // J ∧ B ⇒ vf = x - y > 0
  {
      // J ∧ B ∧ vf = V
      // y ≥ 0 ∧ y * y ≤ x ∧ (y + 1) * (y + 1) ≤ x ∧ x - y = V
      //   ( prepare to update y to y + 1 )
      // y + 1 > 0 ∧ (y + 1) * (y + 1) ≤ x ∧ x - (y + 1) < V
    y := y + 1;
      // y ≥ 0 ∧ y * y ≤ x ∧ x - y < V
      //   J is preserved, and the variant function has decreased.
  }

    // J ∧ ¬B
    // y ≥ 0 ∧ y * y ≤ x ∧ (y + 1) * (y + 1) > x
    // Q: y ≥ 0 ∧ y * y <= x < (y + 1) * (y + 1)
}

/*
   This is in fact a simple linear search for the integer square root of x,
   in which we start with y = 0 and keep incrementing y until 
   (y + 1) * (y + 1) is no longer ≤ x. Therefore, this method is in O(√x).
*/