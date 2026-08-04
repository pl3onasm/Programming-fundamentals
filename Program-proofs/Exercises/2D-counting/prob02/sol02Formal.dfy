/*  file: sol02Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob02
    This is exercise 9.3 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Sets.dfy"
import opened SetSupport
import opened MonotonicityProps

//========================================================================
// Represents the matching points in the remaining rectangle
// [0,x) × [0,y). The first coordinate i ranges over the remaining
// columns, while the second coordinate j ranges over the remaining rows.
ghost function MatchingSet(g:(int,int) -> int, x:nat, 
                           y:nat): set<(nat,nat)>
{
  set i:nat, j:nat | i < x && j < y && g(i,j) <= 0 :: (i,j)
}

//========================================================================
// If the rectangle has zero width or zero height, then the matching set 
// is empty.
lemma EmptySet(g:(int,int) -> int, x:nat, y:nat)
  requires x == 0 || y == 0
  ensures  MatchingSet(g,x,y) == {}
{
  Set2DEquality(MatchingSet(g,x,y), {});
}

//========================================================================
// If g(x-1,y-1) ≤ 0, ascending order in the second argument implies
// g(x-1,j) ≤ g(x-1,y-1) ≤ 0 for every 0 ≤ j < y. Hence every
// point in the rightmost column is a matching point. Removing that
// column reduces the remaining count by exactly y.
lemma CountColumn(g:(int,int) -> int, x:nat, y:nat)
  requires Ordered2DInt(g, Desc, Asc)
  requires x > 0 && y > 0
  requires g(x-1,y-1) <= 0
  ensures |MatchingSet(g,x,y)| == |MatchingSet(g,x-1,y)| + y
{
  var column := ColumnSegment(x-1,0,y);

    // The current matching set is the union of the smaller rectangle
    // obtained by removing the rightmost column and the complete
    // remaining column segment.
  Set2DEquality(MatchingSet(g,x,y), MatchingSet(g,x-1,y) + column);

    // The two parts are disjoint: the removed column has first
    // coordinate x-1, whereas the smaller rectangle has i < x-1
  Set2DEquality(MatchingSet(g,x-1,y) * column, {});

    // The column contains y points with row indices 0,...,y-1
  ColumnSegmentCardinality(x-1,0,y);

    // Thus the cardinality of the union is the sum of both parts
  DisjointUnionCardinality(MatchingSet(g,x-1,y), column);
}

//========================================================================
// If g(x-1,y-1) > 0, descending order in the first argument implies
// g(i,y-1) ≥ g(x-1,y-1) > 0 for every remaining index i < x. Hence the 
// topmost row contains no matching point. Removing that row therefore 
// leaves MatchingSet unchanged.
lemma DiscardRow(g:(int,int) -> int, x:nat, y:nat)
  requires Ordered2DInt(g, Desc, Asc)
  requires x > 0 && y > 0
  requires g(x-1,y-1) > 0
  ensures MatchingSet(g,x,y) == MatchingSet(g,x,y-1)
{
    // Since the removed topmost row contains no matching points,
    // lowering the upper row boundary leaves MatchingSet unchanged.
  Set2DEquality(MatchingSet(g,x,y), MatchingSet(g,x,y-1));
}

//========================================================================
// Counts the matching points by repeatedly removing either the rightmost
// column or the topmost row of the remaining rectangle.
method problem02(g:(int,int) -> int, m:nat, n:nat)
returns  (z:int)
requires Ordered2DInt(g, Desc, Asc)
ensures  z == |MatchingSet(g,m,n)|
{
  var x:nat, y:nat := m,n;
  z := 0;

  while x > 0 && y > 0
      // z stores the number of matching points already removed and
      // counted, while MatchingSet(g,x,y) contains the matching points
      // that remain in the current rectangle. Together, these counts
      // equal the number of matches in the initial rectangle.
    invariant z + |MatchingSet(g,x,y)| == |MatchingSet(g,m,n)|
    decreases x + y
  {
    if g(x-1,y-1) <= 0 
    {
      CountColumn(g,x,y);
      z := z + y;
      x := x - 1;
    } 
    
    else 
    {
      DiscardRow(g,x,y);
      y := y - 1;
    }
  }

    // After the loop, either x = 0 or y = 0. The remaining rectangle
    // therefore has zero width or zero height, so MatchingSet is empty.
    // The cardinality invariant then implies that z is the complete
    // number of matching points.
  EmptySet(g,x,y);
}
