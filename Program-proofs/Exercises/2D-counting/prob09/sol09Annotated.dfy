/* file: sol09Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob09, with annotations
   This is exercise 9.11 from the PC reader
   NOTE: The loop is machine-verified against the recursive
    definition of F. The connection between F(0,w,w) and the set-based
    specification from the problem statement is manually derived and
    justified in the comments, but not machine-verified. This avoids
    the additional technical machinery that would be needed in Dafny
    to formalize sets and cardinalities and to prove the equivalence
    between the set-based specification and the recursive definition
    of F. It also keeps the solution in line with the PC lecture notes.
*/

ghost function F(x:nat, y:nat, w:nat): nat
decreases w - x + y
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(x,y,w) = #{ (i,j) | i,j: x < i ≤  w ∧ 0 ≤ j < y ∧ i² + j² < w² }
    // This function counts the number of points in the rectangle marked by
    //  { (i,j) | x < i ≤ w ∧ 0 ≤ j < y } that lie below the circle defined 
    //  by i² + j² = w². Given the domains of i and j, this comes down to counting
    //  the points that lie within the quarter circle with radius w. 
    // In the initial call F(0,w,w), we call this function on the full rectangle
    //  { (i,j) | 0 < i ≤ w ∧ 0 ≤ j < w }
    // 
    // Base case: x ≥ w or y = 0 then the rectangle is empty and F(x,y,w) = # ∅ = 0
    // Recursive case: the expression i² + j² is increasing in both i and j, so  
    //                 we can shrink the rectangle by either:
    //                 - incrementing x (which removes the leftmost column) or 
    //                 - decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(x,y,w)
    //   = #{ (i,j) | i,j: x < i ≤ w ∧ 0 ≤ j < y ∧ i² + j² < w² }
    //        ( split domain into x + 1 < i ≤ w and i = x + 1 )
    //   = #{ (i,j) | i,j: x + 1 < i ≤ w ∧ 0 ≤ j < y ∧ i² + j² < w² }
    //     + #{ (x+1,j) | j: 0 ≤ j < y ∧ (x+1)² + j² < w² }
    //        ( apply definition of F to the first term )
    //   = F(x+1,y,w) + #{ (x+1,j) | j: 0 ≤ j < y ∧ (x+1)² + j² < w² }
    //        ( (x+1)² + j² is increasing in j, so the value of (x+1)² + (y-1)² 
    //          is maximal; if we assume (x+1)² + (y-1)² < w², then 
    //          (x+1)² + j² < w² for all j < y, and so we can add the whole column 
    //          as it contains only matching points )
    //   = F(x+1,y,w) + #{ (x+1,j) | j: 0 ≤ j < y }
    //        ( size of half-open interval is upper bound - lower bound )
    //   = F(x+1,y,w) + y
    //
    // What happens if we decrement y?  
    //   F(x,y,w)
    //   = #{ (i,j) | i,j: x < i ≤ w ∧ 0 ≤ j < y ∧ i² + j² < w² }
    //        ( split domain into 0 ≤ j < y - 1 and j = y - 1 )
    //   = #{ (i,j) | i,j: x < i ≤ w ∧ 0 ≤ j < y - 1 ∧ i² + j² < w² }
    //     + #{ (i,y-1) | i: x < i ≤ w ∧ i² + (y-1)² < w² }
    //        ( apply definition of F to the first term )
    //   = F(x,y-1,w) + #{ (i,y-1) | i: x < i ≤ w ∧ i² + (y-1)² < w² }
    //        ( i² + (y-1)² is increasing in i, so the value of (x+1)² + (y-1)² 
    //          is minimal; if we assume (x+1)² + (y-1)² ≥ w², then 
    //          i² + (y-1)² ≥ w² for all i > x, and so we can discard the whole row 
    //          as it contains no matching points )
    //   = F(x,y-1,w) + # ∅
    //        ( size of the empty set is 0 )
    //   = F(x,y-1,w) 

  if x >= w || y == 0 
  then 0
  else if (x + 1) * (x + 1) + (y - 1) * (y - 1) < w * w 
       then F(x + 1, y, w) + y
       else F(x, y - 1, w)
} 

method problem09(w:nat) 
returns (r: nat)
ensures r == F(0,w,w)
{
    // Initialization to establish J before the loop
    // P: F(0,w,w) = Z
    //   ( arithmetic )
    // 0 + F(0,w,w) = F(0,w,w)
  var x:nat, y:nat, z:nat := 0, w, 0;
    // J: z + F(x,y,w) = F(0,w,w)

  while x < w && y > 0
  invariant z + F(x,y,w) == F(0,w,w)
  decreases w - x + y
  {
      // J ∧ B ∧ vf = V
      // z + F(x,y,w) = F(0,w,w) ∧ x < w ∧ y > 0 ∧ w - x + y = V
      //   ( we want to apply the recursive definition of F, so we need to 
      //     distinguish the cases (x+1)² + (y-1)² < w² and (x+1)² + (y-1)² ≥ w² )

    if (x + 1) * (x + 1) + (y - 1) * (y - 1) < w * w 
    {
        // z + F(x,y,w) = F(0,w,w) ∧ x < w ∧ y > 0 ∧ (x+1)² + (y-1)² < w² 
        //   ∧ w - x + y = V
        //   ( apply recursive definition of F )
        // z + F(x+1,y,w) + y = F(0,w,w) ∧ w - x + y = V
      z := z + y;
        // z + F(x+1,y,w) = F(0,w,w) ∧ w - x + y = V
        //   ( prepare for incrementing x )
        // z + F(x+1,y,w) = F(0,w,w) ∧ w - (x + 1) + y < V
      x := x + 1;
        // z + F(x,y,w) = F(0,w,w) ∧ w - x + y < V
    }

    else 
    {
        // z + F(x,y,w) = F(0,w,w) ∧ x < w ∧ y > 0 ∧ (x+1)² + (y-1)² ≥ w²
        //   ∧ w - x + y = V
        //   ( apply recursive definition of F )
        // z + F(x,y-1,w) = F(0,w,w) ∧ w - x + y = V
        //   ( prepare for decrementing y )
        // z + F(x,y-1,w) = F(0,w,w) ∧ w - x + (y - 1) < V
      y := y - 1;
        // z + F(x,y,w) = F(0,w,w) ∧ w - x + y < V
    }

    // Collect branches:
    // z + F(x,y,w) = F(0,w,w) ∧ w - x + y < V
    // J ∧ vf < V
    //   ( invariant is preserved and the variant function decreases )
  }
    
    // J ∧ ¬B
    // z + F(x,y,w) = F(0,w,w) ∧ (x ≥ w ∨ y = 0)
    //   ( apply base case of F )
    // z + 0 = F(0,w,w)
  r := z;
    // r = F(0,w,w)
    // Q: r = Z
}

/*
  Since z counts the points in the half-open quadrant given by

    { (i,j) | 0 < i ≤ w ∧ 0 ≤ j < w ∧ i² + j² < w² },

  the four rotations of this region cover all non-origin grid points
  strictly inside the circle. Hence, the total number of grid points 
  strictly inside the circle is 4 * z + 1, where the +1 accounts for 
  the origin.
  
  Since the area of the circle is π * w², we can use the count of grid 
  points to approximate π as follows, for w > 0:

    π ≈ (4 * z + 1) / w²

*/