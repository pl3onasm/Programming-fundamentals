/*  file: sol18PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    solution to prob18, with annotations
    This is exercise 9.20 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport 

ghost function F(f:(nat,nat) -> int, x:nat, y:nat, c:int): int
requires Ordered2DNat(f, Asc, Asc)
requires y <= x
decreases x - y
{
    // We want to find a recursive definition of F that we can use to
    // derive T. We define F as follows:
    //
    //   F(f,x,y,c) = #{ j | j: y ≤ j < x ∧ (∃i: j ≤ i < x ∧ f(i,j) = c) }
    //
    // In other words, F(f,x,y,c) counts the remaining row indices j for 
    // which at least one point (i,j) in the current triangular search region
    // has f-value c. The region is bounded by y ≤ j, j ≤ i, and i < x.
    //
    // We use x as an exclusive upper bound. Hence the initial call 
    // F(f,d+1,0,c) covers exactly the domain 0 ≤ j ≤ d and j ≤ i ≤ d, 
    // from the problem statement.
    //
    // Base case:
    //   If y ≥ x, the remaining triangular search region is empty (since the
    //   upper bound x is exclusive), and so F(f,x,y,c) = # ∅ = 0.
    //
    // Recursive case:
    //   We inspect the south-eastern corner (x-1,y). Depending on its value,
    //   we shrink the search region by either:
    //    - decrementing x, which removes the rightmost column
    //    - incrementing y, which removes the bottommost row
    //
    // What happens if we decrement x?
    //   F(f,x,y,c)
    //   = #{ j | j: y ≤ j < x ∧ (∃i: j ≤ i < x ∧ f(i,j) = c) }
    //      ( split off the rightmost column i = x-1 )
    //   = #{ j | j: y ≤ j < x-1 ∧ (∃i: j ≤ i < x-1 ∧ f(i,j) = c) }
    //     + #{ j | j: y ≤ j < x ∧ (∃i: j ≤ i < x ∧ f(i,j) = c ∧ i = x-1) }
    //      ( apply definition of F to the first term )
    //   = F(f,x-1,y,c) + #{ j | j: y ≤ j < x ∧ (f(x-1,j) = c) }
    //      ( Since f is ascending in its second argument, we have
    //        f(x-1,j) ≥ f(x-1,y) for all y ≤ j < x. If we assume
    //        f(x-1,y) > c, then every point in the rightmost column
    //        has value greater than c. Thus no match is lost by
    //        lowering the exclusive upper bound from x to x-1. )
    //   = F(f,x-1,y,c)
    //
    // What happens if we increment y?
    //   F(f,x,y,c)
    //   = #{ j | j: y ≤ j < x ∧ (∃i: j ≤ i < x ∧ f(i,j) = c) }
    //      ( split off the bottommost row j = y )
    //   = #{ j | j: y+1 ≤ j < x ∧ (∃i: j ≤ i < x ∧ f(i,j) = c) }
    //     + #{ j | j: y ≤ j < x ∧ (∃i: j ≤ i < x ∧ f(i,j) = c ∧ j = y) }
    //      ( apply definition of F to the first term )
    //   = F(f,x,y+1,c) + #{ y | y < x ∧ (∃i: y ≤ i < x ∧ f(i,y) = c) } 
    //      ( Since f is ascending in its first argument, f(x-1,y) is
    //        maximal in the bottommost row. If we assume f(x-1,y) ≤ c,
    //        then the row contains a matching point only if f(x-1,y) = c. 
    //        In that case, we can discard the whole row after adding one
    //        to the overall count. Otherwise, if f(x-1,y) < c, then the  
    //        row contains no matching points, and we can discard the  
    //        whole row without changing the count. )
    //   = F(f,x,y+1,c) + ord(f(x-1,y) = c)

  if y >= x then 0
  else if f(x-1,y) > c
       then F(f,x-1,y,c)
       else F(f,x,y+1,c) + ord(f(x-1,y) == c)
}

method problem18(f:(nat,nat) -> int, c:int, d:nat)
returns (z:int)
requires Ordered2DNat(f, Asc, Asc)
ensures z == F(f,d+1,0,c)
{
    // Initialization to establish J before the loop.
    // P: F(f,d+1,0,c) = Z
    //   ( arithmetic )
    // 0 + F(f,d+1,0,c) = Z
  var x:nat, y:nat := d + 1, 0;
  z := 0;
    // J: z + F(f,x,y,c) = Z

  while y < x
  invariant y <= x
  invariant z + F(f,x,y,c) == F(f,d+1,0,c)
  decreases x - y
  {
      // J ∧ B ∧ vf = V
      // z + F(f,x,y,c) = Z ∧ y < x ∧ x-y = V
      //   ( We want to apply the recursive definition of F, so we
      //     distinguish the cases f(x-1,y) > c and f(x-1,y) ≤ c )

    if f(x-1,y) > c
    {
        // z + F(f,x,y,c) = Z ∧ y < x ∧ f(x-1,y) > c ∧ x-y = V
        //   ( apply the recursive definition of F )
        // z + F(f,x-1,y,c) = Z ∧ x-y = V
        //   ( prepare for decrementing x )
        // z + F(f,x-1,y,c) = Z ∧ (x-1)-y < V
      x := x - 1;
        // z + F(f,x,y,c) = Z ∧ x-y < V
    }

    else
    {
        // z + F(f,x,y,c) = Z ∧ y < x ∧ f(x-1,y) ≤ c ∧ x-y = V
        //   ( apply the recursive definition of F )
        // z + F(f,x,y+1,c) + ord(f(x-1,y) = c) = Z ∧ x-y = V
      z := z + ord(f(x-1,y) == c);
        // z + F(f,x,y+1,c) = Z ∧ x-y = V
        //   ( prepare for incrementing y )
        // z + F(f,x,y+1,c) = Z ∧ x-(y+1) < V
      y := y + 1;
        // z + F(f,x,y,c) = Z ∧ x-y < V
    }

      // Collect branches:
      // z + F(f,x,y,c) = Z ∧ x-y < V
      // J ∧ vf < V
      //   ( The invariant is preserved, and the variant function decreases )
  }

    // J ∧ ¬B
    // z + F(f,x,y,c) = Z ∧ y ≥ x
    //   ( apply the base case of F )
    // z + 0 = Z
    // Q: z = Z
}
