/*  file: sol12PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    solution to prob12, with annotations
    This is exercise 9.14 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(int,int) -> int, x:int, y:int, z:int, m:nat): int
requires Ordered2DInt(h, Asc, Asc)
requires 0 < m 
requires 0 <= x <= m
requires 0 <= y
decreases m - x + y
{
    // We want to find a recursive definition of F that we can use
    // to derive T. We define F as follows:
    //   F(h,x,y,z,m) 
    //     = Min{ {z} ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y} }
    //
    // In other words, F(h,x,y,z,m) is the best value already found, 
    // namely z, minimized with the absolute values in the remaining 
    // rectangle. When this rectangle is non-empty, it is marked by 
    // the north-west corner (x,y-1) and the south-east corner (m-1,0).
    //
    // In the initial call, we use z = abs(h(0,0)). It is guaranteed
    // that (0,0) is one of the points of the full rectangle, because
    // m,n > 0. Given this fact, the initial call F(h,0,n,abs(h(0,0)),m)
    // is equivalent to the set-based specification from the problem 
    // statement.
    //
    // Base case: if x ≥ m or y ≤ 0, then the remaining rectangle is 
    // empty, so the best value is simply z.
    //
    // Recursive case: here we want to shrink the remaining rectangle
    //   by either incrementing x or decrementing y.
    //
    // What happens if we increment x?
    //   F(h,x,y,z,m)
    //     = Min{ {z} ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y} }
    //          ( split domain into i = x and x+1 ≤ i < m )
    //     = Min{ {z} ∪ { |h(x,j)| | j: 0 ≤ j < y} 
    //                ∪ { |h(i,j)| | i,j: x+1 ≤ i < m ∧ 0 ≤ j < y} }
    //       ( Since h is ascending in its second argument, we have
    //         h(x,j) ≤ h(x,y-1) for all 0 ≤ j < y. If we assume
    //         h(x,y-1) < 0, then all these values are negative, and
    //         hence at least as far from 0 as h(x,y-1). Therefore
    //         the best value in column x is the corner (x,y-1) and
    //         we can update z with this value and discard the column. )
    //     = Min{ {minimum(z, abs(h(x,y-1))} 
    //                ∪ { |h(i,j)| | i,j: x+1 ≤ i < m ∧ 0 ≤ j < y} }
    //        ( apply definition of F )
    //     = F(h, x+1, y, minimum(z, abs(h(x,y-1))), m)
    //
    // What happens if we decrement y?
    //   F(h,x,y,z,m)
    //     = Min{ {z} ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y} }
    //          ( split domain into j = y-1 and 0 ≤ j < y-1 )
    //     = Min{ {z} ∪ { |h(i,y-1)| | i: x ≤ i < m} 
    //                ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y-1} }
    //       ( Since h is ascending in its first argument, we have
    //         h(i,y-1) ≥ h(x,y-1) for all x ≤ i < m. If we assume
    //         h(x,y-1) ≥ 0, then all these values are non-negative, 
    //         hence at least as far from 0 as h(x,y-1). Therefore
    //         the best value in row y-1 is the corner (x,y-1) and
    //         we can update z with this value and discard the row. )
    //     = Min{ {minimum(z, abs(h(x,y-1))} 
    //                ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y-1} }
    //        ( apply definition of F )
    //     = F(h, x, y-1, minimum(z, abs(h(x,y-1))), m)

  if x >= m || y <= 0 then z
  else if h(x,y-1) < 0 
       then F(h, x+1, y, minimum(z, abs(h(x,y-1))), m)
       else F(h, x, y-1, minimum(z, abs(h(x,y-1))), m)
}

method problem12(h:(int,int) -> int, m:nat, n:nat)
returns (z:int)
requires Ordered2DInt(h, Asc, Asc)
requires 0 < m && 0 < n
ensures z == F(h,0,n,abs(h(0,0)),m)
{
    // Initialization to establish J before the loop.
    // P: F(h,0,n,abs(h(0,0)),m) = Z
  var x:int, y:int := 0, n;
  z := abs(h(0,0));
    // J: F(h,x,y,z,m) = Z

  while x < m && 0 < y
  invariant 0 <= x <= m
  invariant 0 <= y <= n
  invariant F(h,x,y,z,m) == F(h,0,n,abs(h(0,0)),m)
  decreases m - x + y
  {
      // J ∧ B ∧ vf = V
      // F(h,x,y,z,m) = Z ∧ x < m ∧ 0 < y ∧ m - x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x,y-1) < 0 and h(x,y-1) ≥ 0 )

    if h(x,y-1) < 0
    {
        // F(h,x,y,z,m) = Z ∧ x < m ∧ 0 < y ∧ h(x,y-1) < 0 ∧ m - x + y = V
        //   ( apply recursive definition of F )
        // F(h,x+1,y,minimum(z, abs(h(x,y-1))),m) = Z ∧ m - x + y = V
      z := minimum(z, abs(h(x,y-1)));
        // F(h,x+1,y,z,m) = Z ∧ m - x + y = V
        //   ( prepare for incrementing x )
        // F(h,x+1,y,z,m) = Z ∧ m - (x + 1) + y < V
      x := x + 1;
        // F(h,x,y,z,m) = Z ∧ m - x + y < V
    }

    else
    {
        // F(h,x,y,z,m) = Z ∧ x < m ∧ 0 < y ∧ h(x,y-1) ≥ 0 ∧ m - x + y = V
        //   ( apply recursive definition of F )
        // F(h,x,y-1,minimum(z, abs(h(x,y-1))),m) = Z ∧ m - x + y = V
      z := minimum(z, abs(h(x,y-1)));
        // F(h,x,y-1,z,m) = Z ∧ m - x + y = V
        //   ( prepare for decrementing y )
        // F(h,x,y-1,z,m) = Z ∧ m - x + (y - 1) < V
      y := y - 1;
        // F(h,x,y,z,m) = Z ∧ m - x + y < V
    }

      // Collect branches:
      // F(h,x,y,z,m) = Z ∧ m - x + y < V
      // J ∧ vf < V
      //   ( J is preserved, and the variant function decreases )
  }

    // J ∧ ¬B
    // F(h,x,y,z,m) = Z ∧ ¬(x < m ∧ 0 < y)
    //   ( De Morgan's law )
    // F(h,x,y,z,m) = Z ∧ (x ≥ m ∨ y ≤ 0)
    //   ( apply base case of F )
    // Q: z = Z
}