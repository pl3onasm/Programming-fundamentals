/*  file: sol17PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    solution to prob17, with annotations
    This is exercise 9.19 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, z:int, m:nat, 
                 w:int): int
requires  Ordered2DNat(h, Asc, Asc)
requires  x <= m
decreases m - x + y
{
    // We want to find a recursive definition of F that we can use
    // to derive T.
    //
    // We define F as follows:
    //   F(h,x,y,z,m,w)  
    //   = Min{ {z} ∪ { i + j | i,j: x ≤ i < m ∧ 0 ≤ j < y  ∧ h(i,j) > w} }                            
    //
    // In other words, F(h,x,y,z,m,w) is the best value already found, 
    // namely z, minimized with the candidate values i+j in the remaining 
    // rectangle. When this rectangle is non-empty, it is marked by the
    // north-west corner (x,y-1) and the south-east corner (m-1,0).
    //
    // In the initial call, we use z = m + n, which serves as a sentinel
    // value that functions as infinity, since the largest possible value
    // in the rectangle is i + j = (m-1) + (n-1) = m + n - 2 < m + n. 
    // Since we are computing a minimum, this sentinel value will be 
    // replaced by any smaller value in the rectangle. If the rectangle 
    // is empty, then the sentinel value will be returned.
    // Thus, F computes the minimum of the candidate set when such a
    // matching point exists, and returns the sentinel value m+n when
    // the candidate set is empty.
    //
    // Base case: if x ≥ m or y = 0, then the remaining rectangle is empty,
    // so the best value is simply z.
    //
    // Recursive case: here we want to shrink the remaining rectangle
    //   by either:
    //   - incrementing x (which removes the leftmost column)
    //   - decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,z,m,w)
    //     = Min{ {z} ∪ { i + j | i,j: x ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > w} }
    //       ( split domain into x+1 ≤ i < m and the leftmost column i = x )
    //     = Min{ {z} ∪ { x + j | j: 0 ≤ j < y ∧ h(x,j) > w} 
    //             ∪ { i + j | i,j: x+1 ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > w} }
    //       ( Since h is ascending in its second argument, we have
    //         h(x,j) ≤ h(x,y-1) for all 0 ≤ j < y. Assume h(x,y-1) ≤ w, 
    //         then all these values are ≤ w, and hence there are no matching 
    //         points in the leftmost column, which can thus be discarded 
    //         from the overall minimum. )
    //     = Min{ {z} ∪ { i + j | i,j: x+1 ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > w} }
    //        ( apply definition of F )
    //     = F(h, x+1, y, z, m, w)
    //
    // What happens if we decrement y?
    //   F(h,x,y,z,m,w)
    //     = Min{ {z} ∪ { i + j | i,j: x ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > w} }
    //       ( split domain into 0 ≤ j < y-1 and the topmost row j = y-1 )
    //     = Min{ {z} ∪ { i + (y-1) | i: x ≤ i < m ∧ h(i,y-1) > w}
    //             ∪ { i + j | i,j: x ≤ i < m ∧ 0 ≤ j < y-1 ∧ h(i,j) > w} }
    //       ( Since h is ascending in its first argument, we have
    //         h(i,y-1) ≥ h(x,y-1) for all x ≤ i < m. Assume h(x,y-1) > w, 
    //         then we have h(i,y-1) ≥ h(x,y-1) > w for all x ≤ i < m, and 
    //         hence the best value in the topmost row y-1 is the leftmost 
    //         point (x,y-1). We update z with this value by taking the 
    //         minimum of z and x + (y-1), after which we can discard the
    //         whole row y-1 from the overall minimum. )
    //     = Min{ {minimum(z, x + (y-1))} 
    //            ∪ { i + j | i,j: x ≤ i < m ∧ 0 ≤ j < y-1 ∧ h(i,j) > w} }
    //        ( apply definition of F )
    //     = F(h, x, y-1, minimum(z, x + (y-1)), m, w)

  if x >= m || y == 0 then z
  else if h(x,y-1) <= w
       then F(h, x+1, y, z, m, w)
       else F(h, x, y-1, minimum(z, x + (y-1)), m, w)
}

method problem17(h:(nat,nat) -> int, m:nat, n:nat, w:int)
returns  (z:int)
requires Ordered2DNat(h, Asc, Asc)
ensures  z == F(h,0,n,m+n,m,w)
{
    // Initialization to establish J before the loop.
    // P: F(h,0,n,m+n,m,w) = Z
  var x:nat, y:nat := 0, n;
  z := m + n;
    // J: F(h,x,y,z,m,w) = Z

  while x < m && 0 < y
  invariant x <= m
  invariant y <= n
  invariant F(h,x,y,z,m,w) == F(h,0,n,m+n,m,w)
  decreases (m - x) + y
  {
      // J ∧ B ∧ vf = V
      // F(h,x,y,z,m,w) = Z ∧ x < m ∧ 0 < y ∧ m - x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x,y-1) ≤ w and h(x,y-1) > w )

    if h(x,y-1) <= w
    {
        // F(h,x,y,z,m,w) = Z ∧ x < m ∧ 0 < y ∧ h(x,y-1) ≤ w ∧ m - x + y = V
        //   ( apply recursive definition of F )
        // F(h,x+1,y,z,m,w) = Z ∧ m - x + y = V
        //   ( prepare for incrementing x )
        // F(h,x+1,y,z,m,w) = Z ∧ m - (x + 1) + y < V
      x := x + 1;
        // F(h,x,y,z,m,w) = Z ∧ m - x + y < V
    }

    else
    {
        // F(h,x,y,z,m,w) = Z ∧ x < m ∧ 0 < y ∧ h(x,y-1) > w ∧ m - x + y = V
        //   ( apply recursive definition of F )
        // F(h,x,y-1,minimum(z,x+y-1),m,w) = Z ∧ m - x + y = V
      z := minimum(z, x + y - 1);
        // F(h,x,y-1,z,m,w) = Z ∧ m - x + y = V
        //   ( prepare for decrementing y )
        // F(h,x,y-1,z,m,w) = Z ∧ m - x + (y - 1) < V
      y := y - 1;
        // F(h,x,y,z,m,w) = Z ∧ m - x + y < V
    }

      // Collect branches:
      // F(h,x,y,z,m,w) = Z ∧ m - x + y < V
      // J ∧ vf < V
      //   ( J is preserved, and the variant function decreases )
  }

    // J ∧ ¬B
    // F(h,x,y,z,m,w) = Z ∧ (x ≥ m ∨ y = 0)
    //   ( apply base case of F )
    // Q: z = Z
}