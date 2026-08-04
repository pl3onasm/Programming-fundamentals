/*  file: sol05Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob05
    This is exercise 9.6 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Sets.dfy"

import opened MonotonicityProps
import opened SetSupport

//========================================================================
// Represents the matching points in the remaining triangular search
// region bounded on the left by i = x, above by j = y, and below by the
// diagonal i = j. The initial call MatchingSet(h,0,n,c) represents the
// full triangular domain 0 ≤ i ≤ j < n.
ghost function MatchingSet(h:(int,int) -> int, x:nat, y:nat, 
                           c:int): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i <= j < y && h(i,j) <= c :: (i,j)
}

//========================================================================
// If x ≥ y, no indices can satisfy x ≤ i ≤ j < y. The remaining
// triangular search region is therefore empty, as is the set of
// remaining matching points.
lemma EmptySet(h:(int,int) -> int, x:nat, y:nat, c:int)
  requires x >= y
  ensures MatchingSet(h,x,y,c) == {}
{
  Set2DEquality(MatchingSet(h,x,y,c), {});
}

//========================================================================
// If h(x,y-1) ≤ c, ascending order in h's second argument implies that
// h(x,j) ≤ h(x,y-1) ≤ c for every x ≤ j < y. Hence every point
// in the leftmost column of the remaining triangle is a matching point.
// Removing that column reduces the remaining count by exactly y - x.
lemma CountColumn(h:(int,int) -> int, x:nat, y:nat, c:int)
  requires Ordered2DInt(h, Asc, Asc)
  requires x < y
  requires h(x,y-1) <= c
  ensures |MatchingSet(h,x,y,c)| == |MatchingSet(h,x+1,y,c)| + y - x
{
  var column := ColumnSegment(x,x,y);

    // The current matching set is the union of the matching set with
    // the leftmost column removed and that column segment, which 
    // contains only matching points.
  Set2DEquality(MatchingSet(h,x,y,c), MatchingSet(h,x+1,y,c) + column);

    // The two parts are disjoint: the column segment has first 
    // coordinate x, whereas the smaller triangle contains only 
    // points with i ≥ x + 1
  Set2DEquality(MatchingSet(h,x+1,y,c) * column, {});

    // The half-open column segment contains y - x points
  ColumnSegmentCardinality(x,x,y);

    // Thus the cardinality of the union is the sum of both parts
  DisjointUnionCardinality(MatchingSet(h,x+1,y,c), column);
}

//========================================================================
// If h(x,y-1) > c, ascending order in h's first argument implies that
// h(i,y-1) ≥ h(x,y-1) > c for every remaining index i ≥ x. Hence the 
// topmost row contains no matching points. Removing that row therefore 
// leaves MatchingSet unchanged.
lemma DiscardRow(h:(int,int) -> int, x:nat, y:nat, c:int)
  requires Ordered2DInt(h, Asc, Asc)
  requires x < y
  requires h(x,y-1) > c
  ensures MatchingSet(h,x,y,c) ==
          MatchingSet(h,x,y-1,c)
{
  Set2DEquality(MatchingSet(h,x,y,c), MatchingSet(h,x,y-1,c));
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost
// column or the topmost row of the remaining triangle.
method problem05(h:(int,int) -> int, n:nat, c:int)
returns  (z:int)
requires Ordered2DInt(h, Asc, Asc)
ensures  z == |MatchingSet(h,0,n,c)|
{
  var x:nat, y:nat := 0,n;
  z := 0;

  while x < y
      // z stores the number of matching points already removed and
      // counted, while MatchingSet(h,x,y,c) contains the matching
      // points that remain in the current triangular search region.
      // Together, these counts equal the number of matching points
      // in the original triangular domain.
    invariant z + |MatchingSet(h,x,y,c)| == |MatchingSet(h,0,n,c)|
    decreases y - x
  {
    if h(x,y-1) <= c 
    {
      CountColumn(h,x,y,c);
      z := z + (y - x);
      x := x + 1;
    } 
    
    else 
    {
      DiscardRow(h,x,y,c);
      y := y - 1;
    }
  }

    // After the loop, x ≥ y, so no indices satisfy x ≤ i ≤ j < y.
    // The remaining triangular search region is empty, and the
    // cardinality invariant implies that z is the complete count.
  EmptySet(h,x,y,c);
}
