/*  file: sol07PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D counting, 
    solution to prob07, with annotations
    This is exercise 9.8 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"

import opened MonotonicityProps

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat): int
requires Ordered2DNat(h, Asc, Asc)
decreases n - x + y
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(h,x,y,n) 
    //     = #{ (i,j) | i,j: x ≤ i ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    // This function counts the matching points in the remaining search
    // region bounded by i = x, j = 0, j = y, and the diagonal i + j = n.
    // In the general case, this region has the shape of a trapezium. However,
    // when x + y = n, this trapezium degenerates into a triangle.
    //
    // The initial call F(h,0,n,n) covers the full triangular domain
    // below the diagonal i + j = n.
    //
    // Base case: x ≥ n or y = 0 then the remaining search region is empty 
    //            and so F(h,x,y,n) = # ∅ = 0
    // Recursive case: here we shrink the remaining search region by either 
    //                 - incrementing x (which removes the leftmost column)
    //                 - decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,n)
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    //        ( split domain into x + 1 ≤ i < n and the leftmost column i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i < n ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    //     + #{ (x,j) | j: 0 ≤ j < y ∧ x + j < n ∧ h(x,j) > 0 }
    //        ( apply definition of F to the first term )
    //   = F(h,x+1,y,n) + #{ (x,j) | j: 0 ≤ j < y ∧ j < n - x ∧ h(x,j) > 0 }
    //        ( h(x,j) is ascending in j, so the value of h(x,y-1) is maximal
    //          among the entries of the leftmost column below the current 
    //          upper boundary. If we assume h(x,y-1) ≤ 0, then h(x,j) ≤ 0 for 
    //          all j < y. Hence the part of the leftmost column that lies 
    //          inside the remaining search region contains no matching point 
    //          and can be removed )
    //   = F(h,x+1,y,n) + # ∅
    //        ( size of the empty set is 0 )
    //   = F(h,x+1,y,n)
    //
    // What happens if we decrement y?  
    //   F(h,x,y,n)
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    //        ( split domain into 0 ≤ j < y - 1 and the topmost row j = y - 1 )
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ 0 ≤ j < y - 1 ∧ i + j < n ∧ h(i,j) > 0 }
    //     + #{ (i,y-1) | i: x ≤ i < n ∧ i + y - 1 < n ∧ h(i,y-1) > 0 }
    //        ( apply definition of F to the first term; 
    //          i + y - 1 < n ≡ i + y ≤ n )
    //   = F(h,x,y-1,n) + #{ (i,y-1) | i: x ≤ i < n ∧ i + y ≤ n ∧ h(i,y-1) > 0 }
    //        ( h(i,y-1) is ascending in i, so the value of h(x,y-1) is minimal;
    //          if we assume h(x,y-1) > 0, then h(i,y-1) > 0 for all i ≥ x. 
    //          Hence every point of the top row that lies inside the triangular 
    //          domain is a matching point. When x + y ≤ n, this part of the row 
    //          is the segment [x,n-y+1); when x + y > n, the top row lies 
    //          entirely outside the domain and contributes nothing )
    //   = F(h,x,y-1,n) 
    //     + ( (x + y ≤ n) ? #{ (i,y-1) | i: x ≤ i < n ∧ i + y ≤ n } : # ∅ )
    //        ( the upper bound on the segment is given by i + y ≤ n 
    //          ⇔ i ≤ n - y. Making this upper bound exclusive, we get 
    //          i < n - y + 1, so that the size of the half-open interval 
    //          becomes n - y + 1 - x )
    //   = F(h,x,y-1,n) + ( (x + y ≤ n) ? n - y + 1 - x : 0 )

  if x >= n || y == 0 then 0
  else if h(x, y - 1) <= 0 
       then F(h, x + 1, y, n)
       else if x + y <= n
            then F(h, x, y - 1, n) + n - x - y + 1
            else F(h, x, y - 1, n)
}

method problem07(h:(nat,nat) -> int, n:nat) 
returns (z: int)
requires Ordered2DNat(h, Asc, Asc)
ensures z == F(h,0,n,n)
{
    // Initialization to establish J before the loop
    // P: F(h,0,n,n) = Z
    //   ( arithmetic )
    // 0 + F(h,0,n,n) = Z
  var x, y := 0, n;
  z := 0;
    // J: z + F(h,x,y,n) = Z

  while x < n && y > 0
  invariant z + F(h,x,y,n) == F(h,0,n,n)
  decreases n - x + y
  {   
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,n) = Z ∧ x < n ∧ y > 0 ∧ n - x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x,y-1) ≤ 0 and h(x,y-1) > 0 )

    if h(x, y - 1) <= 0 
    {
        // z + F(h,x,y,n) = Z ∧ h(x,y-1) ≤ 0 
        //   ∧ x < n ∧ y > 0 ∧ n - x + y = V
        //   ( apply definition of F )
        // z + F(h,x+1,y,n) = Z ∧ n - x + y = V
        //   ( prepare incrementing x ) 
        // z + F(h,x+1,y,n) = Z ∧ n - (x + 1) + y < V
      x := x + 1;
        // z + F(h,x,y,n) = Z ∧ n - x + y < V
    }

    else 
    {
      if x + y <= n
      {
          // z + F(h,x,y,n) = Z ∧ h(x,y-1) > 0 ∧ x + y ≤ n   
          //   ∧ x < n ∧ y > 0 ∧ n - x + y = V
          //   ( apply definition of F )
          // z + F(h,x,y-1,n) + n - x - y + 1 = Z ∧ n - x + y = V
        z := z + n - x - y + 1;
          // z + F(h,x,y-1,n) = Z ∧ n - x + y = V
      }

      else 
      {
          // z + F(h,x,y,n) = Z ∧ h(x,y-1) > 0 
          //   ∧ x + y > n ∧ x < n ∧ y > 0 ∧ n - x + y = V
          //   ( apply definition of F )
          // z + F(h,x,y-1,n) = Z ∧ n - x + y = V
      }

        // Collect branches:
        // z + F(h,x,y-1,n) = Z ∧ n - x + y = V
        //   ( prepare decrementing y )
        // z + F(h,x,y-1,n) = Z ∧ n - x + (y - 1) < V
      y := y - 1;
        // z + F(h,x,y,n) = Z ∧ n - x + y < V
    }


      // Collect branches: 
      // z + F(h,x,y,n) = Z ∧ n - x + y < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function decreases )

  }

    // J ∧ ¬B
    // z + F(h,x,y,n) = Z ∧ (x ≥ n || y = 0)
    //   ( apply base case of F )
    // z + 0 = Z
    // Q: z = Z
}