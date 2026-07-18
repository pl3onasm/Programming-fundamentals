/* file: sol15PCStyleAnnotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob15, with annotations
   This is exercise 9.17 from the PC reader
   NOTE: This solution follows the PC-style proof method described
   in the general note on proof styles (see the README in the Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int): int
requires Ordered2DNat(h, Incr, Decr)
requires x <= p
requires y <= p
decreases (p - x) + (p - y)
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(h,x,y,p,w) = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //
    // That is, F(h,x,y,p,w) counts the number of points (i,j) that lie in the 
    // remaining rectangle [x,p) × [y,p), restricted to the quarter-disk domain 
    // i² + j² < p, and that satisfy h(i,j) = w.     
    // For the initial call F(h,0,0,p,w), the explicit coordinate bounds i < p and 
    // j < p are redundant, since they are implied by i² + j² < p for natural i and j.
    // Hence: F(h,0,0,p,w) = #{ (i,j) | i,j: i² + j² < p ∧ h(i,j) = w }, which is 
    // precisely the specification constant Z in the problem statement. 

    // Base case: if x = p or y = p, then the remaining rectangle is empty. 
    // If x² + y² ≥ p, then its south-west corner lies outside the quarter disk. 
    // Since every remaining point satisfies i ≥ x and j ≥ y, it follows that
    // i² + j² ≥ x² + y² ≥ p, so the remaining search area contains no point 
    // satisfying the quarter-disk constraint. Hence F(h,x,y,p,w) = #∅ = 0.
    //
    // Recursive case: here we want to shrink the remaining search area by 
    //   - either incrementing x (which removes the leftmost column)
    //   - or incrementing y (which removes the bottommost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,p,w)
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //      ( split nonempty search domain into leftmost column and remaining area: 
    //        i = x and x + 1 ≤ i < p )
    //   = #{ (i,j) | i,j: x+1 ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w } 
    //     + #{ (x,j) | j: y ≤ j < p ∧ x² + j² < p ∧ h(x,j) = w } 
    //      ( apply definition of F to the first term )
    //   = F(h,x+1,y,p,w) + #{ (x,j) | j: y ≤ j < p ∧ x² + j² < p ∧ h(x,j) = w } 
    //      ( h is strictly decreasing in its second argument, so the value h(x,y) is
    //        maximal for all j ≥ y in the leftmost column. Hence, if we assume 
    //        h(x,y) < w, then h(x,j) < w for all j ≥ y, and we can discard the 
    //        entire column as it does not contain any points satisfying h(i,j) = w. )
    //   = F(h,x+1,y,p,w) + # ∅
    //   = F(h,x+1,y,p,w)
    //
    // What happens if we increment y?
    //   F(h,x,y,p,w)
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //      ( split nonempty search domain into bottommost row and remaining area: 
    //        j = y and y + 1 ≤ j < p )
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y+1 ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w } 
    //     + #{ (i,j) | i: x ≤ i < p ∧ j = y ∧ i² + y² < p ∧ h(i,y) = w }
    //      ( apply definition of F to the first term )
    //   = F(h,x,y+1,p,w) + #{ (i,y) | x ≤ i < p ∧ i² + y² < p ∧ h(i,y) = w } 
    //      ( h is strictly increasing in its first argument, so the value h(x,y) is 
    //        minimal for all i ≥ x in the bottommost row. So, if we assume h(x,y) ≥ w,
    //        then the only point in the row that can satisfy h(i,y) = w is (x,y):
    //        we add 1 to the count iff h(x,y) = w, and we can discard the rest of
    //        the row as it does not contain any other points satisfying h(i,j) = w. )
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
      //     remaining search area, so we need to check the value of h(x,y) )

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
    //   ( apply the base case of F )
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