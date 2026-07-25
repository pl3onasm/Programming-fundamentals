/*  file: sol10Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob10
    This is exercise 9.12 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in 
    the Exercises folder)
*/

include "../../FormalSupport.dfy"
include "../../commonSupport.dfy"
import opened FormalSupport

//========================================================================
// Expresses the monotonicity rules for p. Truth propagates eastward
// and southward, while falsehood propagates westward and northward.
ghost predicate Monotonic(p:(int,int) -> bool)
{
  (forall i,j :: p(i,j)   ==> p(i+1,j)) &&
  (forall i,j :: p(i,j+1) ==> p(i,j))
}

//========================================================================
// Represents the matching points in the remaining triangular region
// bounded on the left by i = x, below by j = y, and above by the line
// i + 2j = m. Points in the region satisfy i + 2j < m. The explicit upper 
// bounds on i and j make the set finite to Dafny, so that we can reason 
// about its cardinality. These upper bounds are implied by the inequality 
// i + 2j < m, but Dafny cannot infer that automatically.
ghost function MatchingSet(p:(int,int) -> bool, x:nat, y:nat, 
                           m:nat): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i < m && y <= j < m && i + 2*j < m && p(i,j)
    :: (i,j)
}

//========================================================================
// Proves that truth of p propagates eastward through a row.
lemma TruthEast(p:(int,int) -> bool, x:nat, i:nat, y:nat)
  requires  Monotonic(p)
  requires  x <= i
  requires  p(x,y)
  ensures   p(i,y)
  decreases i - x
{
  if x < i 
  {
      // By induction, p holds at (i-1,y). The first monotonicity
      // rule then propagates truth one more step east to (i,y)
    TruthEast(p,x,i-1,y);
  }
}

//========================================================================
// Proves that falsehood of p propagates northward through a column.
lemma FalseNorth(p:(int,int) -> bool, x:nat, y:nat, j:nat)
  requires  Monotonic(p)
  requires  y <= j
  requires  !p(x,y)
  ensures   !p(x,j)
  decreases j - y
{
  if y < j 
  {
      // By induction, p is false at (x,j-1). The contrapositive of
      // p(x,j) ==> p(x,j-1) then shows that p is false at (x,j)
    FalseNorth(p,x,y,j-1);
  }
}

//========================================================================
// If the south-west corner lies on or above i + 2j = m, then the
// remaining triangular region is empty, so the set of matching points
// is empty.
lemma EmptySet(p:(int,int) -> bool, x:nat, y:nat, m:nat)
  requires x + 2*y >= m
  ensures  MatchingSet(p,x,y,m) == {}
{
  Set2DEquality(MatchingSet(p,x,y,m), {});
}

//========================================================================
// If p(x,y) is false, falsehood propagates northward, so the entire
// leftmost column contains no matching point, and removing that column 
// leaves the set of remaining matching points unchanged.
lemma DiscardColumn(p:(int,int) -> bool, x:nat, y:nat, m:nat)
  requires Monotonic(p)
  requires x + 2*y < m
  requires !p(x,y)
  ensures  MatchingSet(p,x,y,m) == MatchingSet(p,x+1,y,m)
{   
    // Proves that every point at or above (x,y) in the leftmost
    // column is false. In particular, every point of that column
    // that lies inside the remaining triangle is false.
  forall j:nat | y <= j < m
    ensures !p(x,j)
  {
    FalseNorth(p,x,y,j);
  }
    
    // Proves that the leftmost column contains no matching point and can
    // be discarded without changing the set of remaining matching points
  Set2DEquality(MatchingSet(p,x,y,m), MatchingSet(p,x+1,y,m));
}

//========================================================================
// If p(x,y) is true, truth propagates eastward, so every point in the
// bottom row segment [x,m-2*y) is a matching point. Removing this row
// leaves the triangular region whose lower boundary is y+1, and reduces
// the remaining count by exactly m-2*y-x.
lemma CountRow(p:(int,int) -> bool, x:nat, y:nat, m:nat)
  requires Monotonic(p)
  requires x + 2*y < m
  requires p(x,y)
  ensures |MatchingSet(p,x,y,m)| == |MatchingSet(p,x,y+1,m)| + m - 2*y - x
{
  var row := RowSegment(x,m-2*y,y);
    
    // Proves that every point in the bottom row segment is true
  forall i:nat | x <= i < m-2*y
    ensures p(i,y)
  {
    TruthEast(p,x,i,y);
  }

    // Proves that the current matching set is exactly the union of
    // the matching points above the bottom row and the complete
    // bottom row segment
  Set2DEquality(MatchingSet(p,x,y,m), MatchingSet(p,x,y+1,m) + row);

    // The two parts are disjoint: every point in row has second
    // coordinate exactly y, whereas every point in
    // MatchingSet(p,x,y+1,m) has second coordinate at least y+1
  Set2DEquality(MatchingSet(p,x,y+1,m) * row, {});

    // The row segment contains exactly m - 2*y - x points
  RowSegmentCardinality(x,m-2*y,y);

    // The cardinality of the union is the sum of the
    // cardinalities of its two disjoint parts
  DisjointUnionCardinality(MatchingSet(p,x,y+1,m), row);
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost
// column or the bottommost row of the remaining triangle.
method problem10(p:(int,int) -> bool, m:nat)
returns  (z:int)
requires Monotonic(p)
ensures  z == |MatchingSet(p,0,0,m)|
{
  var x:nat, y:nat := 0,0;
  z := 0;

  while x + 2*y < m
      // The program variable z stores the number of matching points
      // already counted, while the matching points in the remaining 
      // triangle are counted by MatchingSet(p,x,y,m). The sum of these
      // two counts is the total number of matching points in the full
      // triangle, which is the value we want to compute
    invariant z + |MatchingSet(p,x,y,m)| == |MatchingSet(p,0,0,m)|
    decreases m - x - 2*y
  {
    if p(x,y) 
    {
      CountRow(p,x,y,m);
      z := z + m - 2*y - x;
      y := y + 1;
    } 
    
    else 
    {
      DiscardColumn(p,x,y,m);
      x := x + 1;
    }
  }

    // After the loop, x + 2*y >= m, so the lower-left corner lies
    // on or above the diagonal boundary. The remaining triangle is
    // therefore empty, and the cardinality invariant implies that z
    // is the total number of matching points.
  EmptySet(p,x,y,m);
}
