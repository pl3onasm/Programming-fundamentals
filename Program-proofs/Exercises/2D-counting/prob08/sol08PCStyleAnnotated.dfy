/*  file: sol08PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob08, with annotations
    This is exercise 9.9 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport

ghost function F(h:(int,int) -> int, x:nat, y:nat, n:nat): int
requires Ordered2DInt(h, Asc, Asc)
decreases x + (n - y)
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(h,x,y,n) = #{ i | i: 0 ≤ i < x ∧ (∃j: y ≤ j < n ∧ h(i,j) = 0) }
    //
    // This function counts the number of indices i with 0 ≤ i < x
    // for which there exists some j in the range y ≤ j < n such that 
    // h(i,j) = 0.
    // Geometrically, these indices correspond to the columns in the remaining  
    // rectangle that still contain at least one matching point with value 0.
    // In the initial call F(h,m,0,n), we call this function on the full 
    // rectangle given by { i | 0 ≤ i < m ∧ (∃j: 0 ≤ j < n ∧ h(i,j) = 0) }
    //
    // Base case: x = 0 or y ≥ n then the rectangle is empty and so 
    //            F(h,x,y,n) = # ∅ = 0
    // Recursive case: in this case we want to shrink the rectangle by either 
    //                 - decrementing x (which removes the rightmost column) 
    //                 - incrementing y (which removes the bottommost row)

    // What happens if we decrement x?
    //   F(h,x,y,n)
    //   = #{ i | i: 0 ≤ i < x ∧ (∃j: y ≤ j < n ∧ h(i,j) = 0) }
    //        ( split domain into 0 ≤ i < x - 1 and i = x - 1 )
    //   = #{ i | i: 0 ≤ i < x - 1 ∧ (∃j: y ≤ j < n ∧ h(i,j) = 0) } 
    //     + #{ i | i = x - 1 ∧ (∃j: y ≤ j < n ∧ h(i,j) = 0) }
    //        ( apply definition of F to the first term )
    //   = F(h,x-1,y,n) + ( ∃j: y ≤ j < n ∧ h(x-1,j) = 0 ? 1 : 0 )
    //        ( h(x-1,j) is ascending in j, so the value of h(x-1,y) is 
    //          minimal; if we assume h(x-1,y) ≥ 0, then 
    //          h(x-1,j) ≥ h(x-1,y) ≥ 0 for all j ≥ y, and the column x - 1 
    //          contributes to the count iff h(x-1,y) = 0 )
    //   = F(h,x-1,y,n) + ord(h(x-1,y) = 0)
    //
    // What happens if we increment y?
    //   F(h,x,y,n)
    //   = #{ i | i: 0 ≤ i < x ∧ (∃j: y ≤ j < n ∧ h(i,j) = 0) }
    //        ( h(i,y) is ascending in i, so the value of h(x-1,y) is 
    //          maximal; if we assume h(x-1,y) < 0, then 
    //          h(i,y) ≤ h(x-1,y) < 0 for all i < x, and the row y can be 
    //          discarded as it cannot contain any matching points )
    //   = #{ i | i: 0 ≤ i < x ∧ (∃j: y + 1 ≤ j < n ∧ h(i,j) = 0) }
    //        ( apply definition of F )
    //   = F(h,x,y+1,n) 

  if x == 0 || y >= n then 0
  else if h(x-1,y) >= 0 
       then F(h,x-1,y,n) + ord(h(x-1,y) == 0)
       else F(h,x,y+1,n)
}

method problem08(h:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(h, Asc, Asc)
ensures z == F(h,m,0,n)
{
    // Initialization to establish J before the loop
    // P: F(h,m,0,n) = Z
    //   ( arithmetic )
    // 0 + F(h,m,0,n) = Z
  var x:nat, y:nat := m, 0;
  z := 0;
    // J: z + F(h,x,y,n) = Z

  while x > 0 && y < n
  invariant z + F(h,x,y,n) == F(h,m,0,n)
  decreases x + (n - y)
  {
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,n) = Z ∧ x > 0 ∧ y < n ∧ x + (n - y) = V
      //   ( we want to apply the recursive definition of F, so we need
      //     to distinguish the cases h(x-1,y) ≥ 0 and h(x-1,y) < 0 )

    if h(x-1,y) >= 0 
    {
        // z + F(h,x,y,n) = Z ∧ h(x-1,y) ≥ 0 
        //   ∧ x > 0 ∧ y < n ∧ x + (n - y) = V
        //   ( apply definition of F )
        // z + F(h,x-1,y,n) + ord(h(x-1,y) == 0) = Z 
        //   ∧ x + (n - y) = V
      z := z + ord(h(x-1,y) == 0);
        // z + F(h,x-1,y,n) = Z ∧ x + (n - y) = V
        //   ( prepare for decrementing x )
        // z + F(h,x-1,y,n) = Z ∧ (x - 1) + (n - y) < V
      x := x - 1;
        // z + F(h,x,y,n) = Z ∧ x + (n - y) < V
    }

    else 
    {
        // z + F(h,x,y,n) = Z ∧ h(x-1,y) < 0 
        //   ∧ x > 0 ∧ y < n ∧ x + (n - y) = V
        //   ( apply definition of F )
        // z + F(h,x,y+1,n) = Z ∧ x + (n - y) = V
        //   ( prepare for incrementing y )
        // z + F(h,x,y+1,n) = Z ∧ x + (n - (y + 1)) < V
      y := y + 1;
        // z + F(h,x,y,n) = Z ∧ x + (n - y) < V
    }

      // Collect branches:
      // z + F(h,x,y,n) = Z ∧ x + (n - y) < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // z + F(h,x,y,n) = Z ∧ (x = 0 ∨ y ≥ n)
    //   ( apply the base case of F )
    // z + 0 = Z
    // Q: z = Z
}