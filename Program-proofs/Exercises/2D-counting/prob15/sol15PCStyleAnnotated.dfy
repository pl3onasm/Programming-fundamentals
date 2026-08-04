/* file: sol15PCStyleAnnotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob15, with annotations
   This is exercise 9.17 from the PC reader
   NOTE: This solution follows the PC-style proof method described
   in the general note on proof styles (see the README in the Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport   

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int): int
requires Ordered2DNat(h, Incr, Decr)
requires x <= p
requires y <= p
decreases (p - x) + (p - y)
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(h,x,y,p,w) 
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //
    // Thus, F(h,x,y,p,w) counts the matching points in the remaining search
    // region bounded by i = x, j = y, and the circular arc i² + j² = p.
    //
    // Unlike in problem 9, the circular arc i² + j² = p bounds the search 
    // domain. It is not the contour line being followed by the search. The 
    // contour line is instead determined by h(i,j) = w. This is why the 
    // search domain is a quarter disk in this problem, rather than a 
    // rectangle as in problem 9. 

    // Base case: if x = p or y = p, then no points remain to be counted.
    // If x² + y² ≥ p, then the south-west corner lies on or outside the 
    // quarter disk. Since every remaining point satisfies i ≥ x and j ≥ y, 
    // it follows that i² + j² ≥ x² + y² ≥ p. Hence no remaining point
    // lies strictly inside the quarter disk, and F(h,x,y,p,w) = #∅ = 0.
    //
    // Recursive case: we shrink the remaining quarter-disk region by
    //   - incrementing x, which removes its leftmost column
    //   - incrementing y, which removes its bottommost row
    //
    // What happens if we increment x?
    //   F(h,x,y,p,w)
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //      ( split the nonempty quarter-disk search region into the part
    //        of its leftmost column with i = x and the remaining region
    //        with x + 1 ≤ i < p )
    //   = #{ (i,j) | i,j: x+1 ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w } 
    //     + #{ (x,j) | j: y ≤ j < p ∧ x² + j² < p ∧ h(x,j) = w } 
    //      ( apply definition of F to the first term )
    //   = F(h,x+1,y,p,w) + #{ (x,j) | j: y ≤ j < p ∧ x² + j² < p ∧ h(x,j) = w } 
    //      ( h is strictly decreasing in its second argument, so h(x,y)
    //        is maximal among all remaining points of the leftmost column.
    //        If h(x,y) < w, then h(x,j) < w for every j ≥ y. Hence the
    //        part of this column lying inside the quarter disk contains
    //        no matching point and can be removed )
    //   = F(h,x+1,y,p,w) + # ∅
    //   = F(h,x+1,y,p,w)
    //
    // What happens if we increment y?
    //   F(h,x,y,p,w)
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //      ( split the nonempty quarter-disk search region into the part
    //        of its bottommost row with j = y and the remaining region
    //        with y + 1 ≤ j < p )
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y+1 ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w } 
    //     + #{ (i,j) | i: x ≤ i < p ∧ j = y ∧ i² + y² < p ∧ h(i,y) = w }
    //      ( apply definition of F to the first term )
    //   = F(h,x,y+1,p,w) + #{ (i,y) | x ≤ i < p ∧ i² + y² < p ∧ h(i,y) = w } 
    //      ( h is strictly increasing in its first argument, so h(x,y)
    //        is minimal among all remaining points of the bottommost row.
    //        If h(x,y) ≥ w, then every point farther east has value
    //        strictly greater than h(x,y). Therefore (x,y) is the only
    //        possible match in that row. We add 1 exactly when h(x,y) = w, 
    //        after which the rest of the row can be removed )
    //   = F(h,x,y+1,p,w) + ord(h(x,y) == w)

  if x == p || y == p || x * x + y * y >= p then
    0
  else if h(x,y) < w then
    F(h, x + 1, y, p, w)
  else 
    F(h, x, y + 1, p, w) + ord(h(x,y) == w)
}

method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z:int)
requires Ordered2DNat(h, Incr, Decr)
ensures z == F(h, 0, 0, p, w)
{
    // Initialization to establish J before the loop
    // P: F(h,0,0,p,w) = Z
    //   ( arithmetic )
    // 0 + F(h,0,0,p,w) = Z
  var x:nat, y:nat := 0, 0;
  z := 0;
    // J: z + F(h,x,y,p,w) = Z

  while x*x + y*y < p
    invariant 0 <= x <= p
    invariant 0 <= y <= p
    invariant z + F(h, x, y, p, w) == F(h, 0, 0, p, w)
    decreases (p - x) + (p - y)
  {
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,p,w) = Z ∧ x*x + y*y < p ∧ (p - x) + (p - y) = V
      //   ( we want to apply the recursive definition of F to shrink the
      //     remaining quarter-disk search region, so we inspect h(x,y) )

    if h(x,y) < w 
    {
        // z + F(h,x,y,p,w) = Z ∧ x*x + y*y < p ∧ h(x,y) < w ∧ (p - x) + (p - y) = V
        //   ( apply definition of F; as x*x + y*y < p, we are not in the base case )
        // z + F(h,x+1,y,p,w) = Z ∧ (p - x) + (p - y) = V
        //   ( prepare for incrementing x )
        // z + F(h,x+1,y,p,w) = Z ∧ (p - (x+1)) + (p - y) < V
      x := x + 1;
        // z + F(h,x,y,p,w) = Z ∧ (p - x) + (p - y) < V
    } 

    else 
    {
        // z + F(h,x,y,p,w) = Z ∧ x*x + y*y < p ∧ h(x,y) ≥ w ∧ (p - x) + (p - y) = V
        //   ( apply definition of F; as x*x + y*y < p, we are not in the base case )
        // z + F(h,x,y+1,p,w) + ord(h(x,y) == w) = Z ∧ (p - x) + (p - y) = V 
      z := z + ord(h(x,y) == w);
        // z + F(h,x,y+1,p,w) = Z ∧ (p - x) + (p - y) = V
        //   ( prepare for incrementing y )
        // z + F(h,x,y+1,p,w) = Z ∧ (p - x) + (p - (y+1)) < V
      y := y + 1;
        // z + F(h,x,y,p,w) = Z ∧ (p - x) + (p - y) < V
    }

      // Collect branches:
      // z + F(h,x,y,p,w) = Z ∧ (p - x) + (p - y) < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // z + F(h,x,y,p,w) = Z ∧ x*x + y*y ≥ p
    //   ( the south-west corner lies on or outside the circular boundary,
    //     so the remaining quarter-disk search region is empty; apply the
    //     base case of F )
    // z + 0 = Z
    // Q: z = Z
}


/*
   Note on time complexity:
   Each iteration increments x or y. While the loop guard holds, we have
   x² + y² < p, which implies that x < √p and y < √p. Hence x and y
   remain bounded by √p during the active part of the search. Since at
   least one of them is increased in every iteration, the number of
   iterations is in O(√p).
*/