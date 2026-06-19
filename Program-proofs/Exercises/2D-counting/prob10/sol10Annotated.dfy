/* file: sol10Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob10, with annotations
   This is exercise 9.12 from the PC reader
   NOTE: The loop is machine-verified against the recursive definition of F. 
    The connection between F(p,0,0,m) and the set-based specification from the 
    problem statement is manually derived and justified in the comments, but 
    not machine-verified. This avoids the additional technical machinery that 
    would be needed in Dafny to introduce the corresponding finite sets, 
    reason about their cardinalities, and prove the equivalence of the 
    set-based specification and the recursive definition of F. It also keeps 
    the solution in line with the PC lecture notes.
*/

ghost predicate prop(p:(int,int) -> bool)
{
    // Expresses the monotonicity rules for p, as given in the problem statement.
    // It states that truth of p propagates eastward and southward, and
    // that falsehood of p propagates westward and northward.
  (forall i,j:: p(i,j)   ==> p(i+1,j)) &&
  (forall i,j:: p(i,j+1) ==> p(i,j))
}

ghost function F(p:(int,int) -> bool, x:int, y:int, m:nat): int
requires prop(p)
decreases m - x - 2 * y
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(p,x,y,m) = #{ (i,j) | i,j: x ≤ i ∧ y ≤ j ∧ i + 2 * j < m ∧ p(i,j) }
    // In other words, F(p,x,y,m) counts the number of points (i,j) in the triangle
    // defined by the inequalities x ≤ i ∧ y ≤ j ∧ i + 2 * j < m, for which p(i,j) holds.
    // In the initial call, we have F(p,0,0,m), which counts the number of points (i,j) 
    // in the full triangle marked by the lines x = 0, y = 0, and i + 2 * j = m.
    //
    // Base case: if x + 2*y ≥ m, then the triangle is empty, so F(p,x,y,m) = # ∅ = 0.
    // Recursive case: if x + 2*y < m, we want to shrink the triangle by either
    //                 - incrementing x (which removes the leftmost column) or
    //                 - incrementing y (which removes the bottommost row)
    //
    // What happens if we increment x?
    //   F(p,x,y,m) 
    //   = #{ (i,j) | i,j: x ≤ i ∧ y ≤ j ∧ i + 2 * j < m ∧ p(i,j) }
    //        ( split domain into x + 1 ≤ i and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i ∧ y ≤ j ∧ i + 2 * j < m ∧ p(i,j) }
    //     + #{ (x,j) | j: y ≤ j ∧ x + 2 * j < m ∧ p(x,j) }
    //        ( apply definition of F to the first term )
    //   = F(p,x+1,y,m) + #{ (x,j) | j: y ≤ j ∧ x + 2 * j < m ∧ p(x,j) }
    //        ( truth of p(x,j) is descending in j, meaning that falsehood of p
    //          propagates northward. So if we assume p(x,y) is false, then p(x,j) 
    //          is false for all j ≥ y, and so we can ignore the whole column )
    //   = F(p,x+1,y,m) + # ∅
    //   = F(p,x+1,y,m)
    //
    // What happens if we increment y?
    //   F(p,x,y,m)
    //   = #{ (i,j) | i,j: x ≤ i ∧ y ≤ j ∧ i + 2 * j < m ∧ p(i,j) }
    //        ( split domain into y + 1 ≤ j and j = y )
    //   = #{ (i,j) | i,j: x ≤ i ∧ y + 1 ≤ j ∧ i + 2 * j < m ∧ p(i,j) }
    //     + #{ (i,y) | i: x ≤ i ∧ i + 2 * y < m ∧ p(i,y) }
    //        ( apply definition of F to the first term )
    //   = F(p,x,y+1,m) + #{ (i,y) | i: x ≤ i ∧ i + 2 * y < m ∧ p(i,y) }
    //        ( truth of p(i,y) is ascending in i, meaning that truth of p
    //          propagates eastward. So if we assume p(x,y) is true,
    //          then p(i,y) is true for all i ≥ x, and so we can add the whole row )
    //   = F(p,x,y+1,m) + #{ (i,y) | i: x ≤ i ∧ i + 2 * y < m }
    //        ( size of half-open interval is upper bound - lower bound )
    //   = F(p,x,y+1,m) + (m - 2 * y) - x

  if x + 2 * y >= m 
  then 0
  else if p(x,y) 
       then F(p,x,y+1,m) + m - 2 * y - x
       else F(p,x+1,y,m)
}

method problem10(p:(int,int) -> bool, m:nat)
returns (r: int)
requires prop(p)
ensures r == F(p,0,0,m)
{
    // Initialization to establish J before the loop
    // P: F(p,0,0,m) = Z
    //    ( arithmetic )
    // 0 + F(p,0,0,m) = F(p,0,0,m)
  var x:int, y:int, z:int := 0, 0, 0;
    // J: z + F(p,x,y,m) = F(p,0,0,m)

  while x + 2 * y < m
  invariant z + F(p,x,y,m) == F(p,0,0,m)
  decreases m - x - 2 * y
  {   
      // J ∧ B ∧ vf = V
      // z + F(p,x,y,m) = F(p,0,0,m) ∧ x + 2 * y < m ∧ m - x - 2 * y = V
      //   ( note that vf = V > 0 because of B: x + 2 * y < m;
      //     we now want to apply the recursive definition of F, 
      //     so we need to consider the cases for p(x,y) )

    if p(x,y) 
    {
        // z + F(p,x,y,m) = F(p,0,0,m) ∧ x + 2 * y < m ∧ p(x,y) ∧ m - x - 2 * y = V
        //   ( apply definition of F )
        // z + F(p,x,y+1,m) + m - 2 * y - x = F(p,0,0,m) ∧ m - x - 2 * y = V
      z := z + m - 2 * y - x;
        // z + F(p,x,y+1,m) = F(p,0,0,m) ∧ m - x - 2 * y = V
        //   ( prepare for incrementing y )
        // z + F(p,x,y+1,m) = F(p,0,0,m) ∧ m - x - 2 * (y + 1) < V
      y := y + 1;
        // z + F(p,x,y,m) = F(p,0,0,m) ∧ m - x - 2 * y < V
    }

    else 
    {
        // z + F(p,x,y,m) = F(p,0,0,m) ∧ x + 2 * y < m ∧ ¬p(x,y) ∧ m - x - 2 * y = V
        //   ( apply definition of F )
        // z + F(p,x+1,y,m) = F(p,0,0,m) ∧ m - x - 2 * y = V
        //   ( prepare for incrementing x )
        // z + F(p,x+1,y,m) = F(p,0,0,m) ∧ m - (x + 1) - 2 * y < V
      x := x + 1;
        // z + F(p,x,y,m) = F(p,0,0,m) ∧ m - x - 2 * y < V
    }

      // Collect branches:
      // z + F(p,x,y,m) = F(p,0,0,m) ∧ m - x - 2 * y < V
      // J ∧ vf < V
      //   ( J is preserved, and the variant function decreases ) 
  }

    // J ∧ ¬B
    // z + F(p,x,y,m) = F(p,0,0,m) ∧ ¬(x + 2 * y < m)
    //   ( apply base case of F )
    // z + 0 = F(p,0,0,m) 
  r := z;
    // r = F(p,0,0,m)
    // Q: r = Z
}