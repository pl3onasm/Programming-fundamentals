/*  file: sol02PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob02, with annotations
    This is exercise 9.3 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
import opened MonotonicityProps

ghost function F(g:(int,int) -> int, x:int, y:int): int
requires Ordered2DInt(g, Desc, Asc)
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // F is defined as:
    //   F(g,x,y) = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ g(i,j) ≤ 0 }
    // This function counts the number of points in the rectangle 
    // [0,x) × [0,y) that satisfy g(i,j) ≤ 0. 
    //
    // Base case: x ≤ 0 or y ≤ 0, then the rectangle is empty 
    //            and F(g,x,y) = # ∅ = 0.
    // Recursive case: here we want to shrink the rectangle by either
    //                 - decrementing x (which removes the rightmost column)
    //                 - decrementing y (which removes the topmost row) 
    //
    // What happens if we decrement x? 
    //   F(g,x,y)
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ g(i,j) ≤ 0 }
    //       ( split domain into 0 ≤ i < x-1 and the rightmost column i = x-1 )
    //   = #{ (i,j) | i,j: 0 ≤ i < x-1 ∧ 0 ≤ j < y ∧ g(i,j) ≤ 0 }
    //     + #{ (x-1,j) | j: 0 ≤ j < y ∧ g(x-1,j) ≤ 0 }
    //       ( apply definition of F to the first term )
    //   = F(g, x-1,y) + #{ (x-1,j) | j: 0 ≤ j < y ∧ g(x-1,j) ≤ 0 }
    //       ( note that the second term counts the number of points in the 
    //         last column: assume g(x-1,y-1) ≤ 0, then since g is ascending 
    //         in its second argument, g(x-1,y-1) is maximal and we have 
    //         g(x-1,j) ≤ 0 for all 0 ≤ j < y, so we can add all points in 
    //         the rightmost column to the overall count )
    //   = F(g, x - 1,y) + #{ j | j: 0 ≤ j < y }
    //        ( size of half-open interval [0,y) = y - 0 = y )
    //   = F(g, x - 1,y) + y
    //
    // What happens if we decrement y?
    //   F(g, x,y)
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ g(i,j) ≤ 0 }
    //       ( split domain into 0 ≤ j < y-1 and the topmost row j = y-1 )
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y-1 ∧ g(i,j) ≤ 0 }
    //     + #{ (i,y-1) | i: 0 ≤ i < x ∧ g(i,y-1) ≤ 0 }
    //       ( apply definition of F to the first term )
    //   = F(g, x, y-1) + #{ (i,y-1) | i: 0 ≤ i < x ∧ g(i,y-1) ≤ 0 }
    //       ( note that the second term counts the number of points in 
    //         the upper row; assume g(x-1,y-1) > 0, then since g is 
    //         descending in its first argument, g(x-1,y-1) is minimal 
    //         and we have g(i,y-1) > 0 for all 0 ≤ i < x, meaning that
    //         the upper row contains no matching points and we can 
    //         discard it from the overall count )
    //   = F(g, x, y-1) + # ∅
    //       ( size of empty set is 0 )
    //   = F(g, x, y-1)

  if x <= 0 || y <= 0 then 0
  else if g(x-1,y-1) <= 0 then F(g,x-1,y) + y
  else F(g,x,y-1)
}

method problem02(g:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(g, Desc, Asc)
ensures z == F(g,m,n)
{
    // Initialization to establish J before the loop
    // P: F(g,m,n) = Z
    //   ( arithmetic )
    // 0 + F(g,m,n) = Z
  var x, y := m, n;
  z := 0;
    // J: z + F(g,x,y) = Z

  while x > 0 && y > 0
  invariant z + F(g,x,y) == F(g,m,n)
  decreases x + y
  {
      // J ∧ B ∧ vf = V
      // z + F(g,x,y) = Z ∧ x > 0 ∧ y > 0 ∧ x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases g(x-1,y-1) ≤ 0 and g(x-1,y-1) > 0 )

    if g(x-1,y-1) <= 0
    {
        // z + F(g,x,y) = Z ∧ g(x-1,y-1) ≤ 0 ∧ x > 0 ∧ y > 0 ∧ x + y = V
        //   ( apply definition of F; 
        //     since x > 0 ∧ y > 0, we are not in the base case )
        // z + F(g,x-1,y) + y = Z ∧ x + y = V
      z := z + y;
        // z + F(g,x-1,y) = Z ∧ x + y = V
        //   ( prepare for decrementing x )
        // z + F(g,x-1,y) = Z ∧ x - 1 + y < V
      x := x - 1;
        // z + F(g,x,y) = Z ∧ x + y < V
    }

    else
    {
        // z + F(g,x,y) = Z ∧ g(x-1,y-1) > 0 ∧ x > 0 ∧ y > 0 ∧ x + y = V
        //   ( apply definition of F; 
        //     since x > 0 ∧ y > 0, we are not in the base case )
        // z + F(g,x,y-1) = Z ∧ x + y = V
        //   ( prepare for decrementing y )
        // z + F(g,x,y-1) = Z ∧ x + y - 1 < V
      y := y - 1;
        // z + F(g,x,y) = Z ∧ x + y < V
    }

      // Collect branches:
      // z + F(g,x,y) = Z ∧ x + y < V
      // J ∧ vf < V
      //   ( J is preserved and vf has decreased )
  }

    // J ∧ ¬B
    // z + F(g,x,y) = Z ∧ x ≤ 0 ∨ y ≤ 0
    //   ( apply base case of F )
    // z + 0 = Z
    // Q: z = Z
}