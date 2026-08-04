/*  file: sol03Annotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob03, with annotations
    This is exercise 9.4 from the PC reader

    NOTE: here we take the same approach as in prob02, by starting the 
    search from the upper-right corner and shrinking the rectangle in 
    a south-western direction by either decrementing x or y. 
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport

ghost function F(h:(int,int) -> int, x:int, y:int, w:int): int
requires Ordered2DInt(h, Decr, Asc)
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // F is defined as:
    //   F(h,x,y,w) = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    // This function counts the number of points in the rectangle 
    // [0,x) × [0,y) that satisfy h(i,j) = w. 
    //
    // Base case: x ≤ 0 or y ≤ 0, then the rectangle is empty 
    //            and F(x,y) = # ∅ = 0.
    // Recursive case: here we want to shrink the rectangle by either
    //                 - decrementing x (which removes the rightmost column)
    //                 - decrementing y (which removes the topmost row)
    //
    // What happens if we decrement x? 
    //   F(x,y)
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    //       ( split domain into 0 ≤ i < x-1 and the rightmost column i = x-1 )
    //   = #{ (i,j) | i,j: 0 ≤ i < x-1 ∧ 0 ≤ j < y ∧ h(i,j) = w }
    //     + #{ (x-1,j) | j: 0 ≤ j < y ∧ h(x-1,j) = w }
    //       ( apply definition of F to the first term )
    //   = F(h, x-1,y,w) + #{ (x-1,j) | j: 0 ≤ j < y ∧ h(x-1,j) = w }
    //       ( h(x-1, j) is ascending in j, so the value of h(x-1,y-1) 
    //         is maximal. If we assume h(x-1,y-1) < w, then h(x-1,j) < w 
    //         for all 0 ≤ j < y and we can discard the whole column x-1 
    //         as it contains no matching points )
    //   = F(h, x - 1,y,w) + # ∅
    //   = F(h, x - 1,y,w)
    //
    // What happens if we decrement y?
    //   F(h,x,y,w)
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    //       ( split domain into 0 ≤ j < y-1 and the topmost row j = y-1 )
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y-1 ∧ h(i,j) = w }
    //     + #{ (i,y-1) | i: 0 ≤ i < x ∧ h(i,y-1) = w }
    //       ( apply definition of F to the first term )
    //   = F(h, x, y-1, w) + #{ (i,y-1) | i: 0 ≤ i < x ∧ h(i,y-1) = w }
    //       ( h(i,y-1) is strictly decreasing in i, so the value of 
    //         h(x-1,y-1) is minimal. If we assume h(x-1,y-1) ≥ w, then 
    //         either h(x-1,y-1) = w for only that point or h(i,y-1) > w 
    //         for all 0 ≤ i < x. So we add one matching point to the 
    //         overall count if h(x-1,y-1) = w, after which we can discard 
    //         the whole row y-1 )
    //   = F(h, x, y-1, w) + ord(h(x-1,y-1) = w)

  if x <= 0 || y <= 0 then 0
  else if h(x - 1, y - 1) < w then F(h, x - 1, y, w)
  else F(h, x, y - 1, w) + ord(h(x - 1, y - 1) == w)
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (z: int)
requires Ordered2DInt(h, Decr, Asc)
ensures z == F(h, m ,n, w)
{
    // Initialization to establish J before the loop
    // P: F(h,m,n,w) = Z
    //   ( arithmetic )
    // 0 + F(h,m,n,w) = Z
  var x, y := m, n;
  z := 0;
    // J: z + F(h,x,y,w) = Z

  while x > 0 && y > 0
  invariant z + F(h, x, y, w) == F(h, m, n, w)
  decreases x + y
  {
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,w) = Z ∧ x > 0 ∧ y > 0 ∧ x + y = V
      //   ( to apply the recursive definition of F, we need to
      //     distinguish the cases h(x-1,y-1) < w and h(x-1,y-1) ≥ w )

    if h(x - 1, y - 1) < w
    {
        // z + F(h,x,y,w) = Z ∧ h(x-1,y-1) < w ∧ x > 0 ∧ y > 0 
        //   ∧ x + y = V
        //   ( apply definition of F; since x > 0 ∧ y > 0, 
        //     we are not in the base case )
        // z + F(h,x-1,y,w) = Z ∧ x + y = V
        //   ( prepare for decrementing x )
        // z + F(h,x-1,y,w) = Z ∧ x - 1 + y < V
      x := x - 1;
        // z + F(h,x,y,w) = Z ∧ x + y < V
    }

    else
    {
        // z + F(h,x,y,w) = Z ∧ h(x-1,y-1) ≥ w ∧ x > 0 ∧ y > 0 
        //   ∧ x + y = V
        //   ( apply definition of F; since x > 0 ∧ y > 0, 
        //     we are not in the base case )
        // z + F(h,x,y-1,w) + ord(h(x-1,y-1) = w) = Z ∧ x + y = V
      z := z + ord(h(x - 1, y - 1) == w);
        // z + F(h,x,y-1,w) = Z ∧ x + y = V
        //   ( prepare for decrementing y )
        // z + F(h,x,y-1,w) = Z ∧ x + (y - 1) < V
      y := y - 1;
        // z + F(h,x,y,w) = Z ∧ x + y < V
    }

      // Collect branches:
      // z + F(h,x,y,w) = Z ∧ x + y < V
      // J ∧ vf < V
      //   ( J is preserved and vf has decreased )
  }

    // J ∧ ¬B
    // z + F(h,x,y,w) = Z ∧ x ≤ 0 ∨ y ≤ 0
    //   ( apply base case of F )
    // z + 0 = Z
    // Q: z = Z
}