/* file: sol05Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob05, with annotations
   This is exercise 7.5 from the PC reader
*/

method problem05(x:nat, y:nat) returns (q:nat, r:nat)
requires y > 0
ensures  x == q * y + r && 0 <= r < y
{
    // Initialization to establish J before the loop 
    // P: 0 < y
    //    ( x is a natural number, so 0 <= x )
    // x = 0 * y + x ∧ 0 ≤ x
  q := 0;
  r := x;
    // J: x = q * y + r ∧ 0 ≤ r

  while r >= y
    invariant x == q * y + r && 0 <= r
    decreases r
  {   
      // J ∧ B ∧ vf = V
      // x = q * y + r ∧ 0 ≤ r ∧ r >= y ∧ r = V
      //   ( prepare for updating r to r - y )
      //   ( since r >= y, we have 0 <= r - y )
      // x = q * y + (r - y) + y ∧ 0 ≤ r - y < V
    r := r - y;
      // x = q * y + r + y ∧ 0 ≤ r < V
      //   ( prepare for updating q to q + 1 )
      // x = (q + 1) * y + r ∧ 0 ≤ r < V
    q := q + 1;
      // x = q * y + r ∧ 0 ≤ r < V
      //   J is preserved, and the variant function has decreased.
  }

    // J ∧ ¬B
    // x = q * y + r ∧ 0 ≤ r ∧ r < y
    // Q: x == q * y + r ∧ 0 <= r < y
}

/*
   This method implements division by repeated subtraction. 
   As long as r is greater than or equal to y, we keep subtracting 
   y from r and incrementing q by 1. This method is in O(x / y), which 
   becomes O(x) in the worst case when y = 1.
*/