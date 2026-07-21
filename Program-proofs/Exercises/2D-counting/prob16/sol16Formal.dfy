/*  file: sol16Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob16
    This is exercise 9.18 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../FormalSupport.dfy"
include "../../commonSupport.dfy"
import opened FormalSupport
import opened MonotonicityProps

//========================================================================
// Represents the matching points in the remaining triangular region
// bounded by j = y, i = x, and 2j = i. For the initial call, the explicit 
// bound j < n is redundant, since 2j ≤ i < n implies j < n; it is 
// included to make finiteness explicit to Dafny.
ghost function MatchingSet(f:(nat,nat) -> int, x:nat, y:nat,
                           n:nat, w:int): set<(nat,nat)>
{
  set i:nat, j:nat | y <= j < n && 2*j <= i < x && f(i,j) < w :: (i,j)
}

//========================================================================
// If the right boundary has reached zero, the lower boundary has reached
// n, or the south-east corner has reached or crossed the line 2j = i, 
// there are no remaining matching points in the triangular region.
lemma EmptySet(f:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int)
  requires x == 0 || y == n || 2*y >= x
  ensures MatchingSet(f,x,y,n,w) == {}
{
    // Under any of the three boundary conditions, no indices can
    // satisfy y ≤ j < n and 2*j ≤ i < x
  Set2DEquality(MatchingSet(f,x,y,n,w), {});
}

//========================================================================
// If f(x-1,y) ≥ w, ascending order in the second argument implies that
// the entire rightmost column contains no matching points and can be 
// discarded from the total count.
lemma DiscardColumn(f:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int)
  requires Ordered2DNat(f, Asc, Asc)
  requires x > 0 && y < n && 2*y < x
  requires f(x-1,y) >= w
  ensures MatchingSet(f,x,y,n,w) == MatchingSet(f,x-1,y,n,w)
{
    // For every j ≥ y, ascending order in the second argument gives
    // f(x-1,j) ≥ f(x-1,y) ≥ w. Therefore, the rightmost column
    // contains no matching points
  Set2DEquality(MatchingSet(f,x,y,n,w), MatchingSet(f,x-1,y,n,w));
}

//========================================================================
// If f(x-1,y) < w, ascending order in the first argument implies that
// every point in the bottom row segment [2y,x) is a matching point and 
// can be added to the total count. The segment can then be discarded 
// from the remaining triangular region by incrementing y.
lemma AdvanceRow(f:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int)
  requires Ordered2DNat(f, Asc, Asc)
  requires x > 0 && y < n && 2*y < x
  requires f(x-1,y) < w
  ensures |MatchingSet(f,x,y,n,w)| == |MatchingSet(f,x,y+1,n,w)| + x - 2*y
{
  var row := RowSegment(2*y,x,y);

    // Split the remaining triangle into the bottom row and the
    // smaller triangle above it
  Set2DEquality(MatchingSet(f,x,y,n,w), MatchingSet(f,x,y+1,n,w) + row);

    // The smaller triangle contains only rows j ≥ y+1, whereas
    // every point in row has second coordinate y; hence the two 
    // sets are disjoint
  Set2DEquality(MatchingSet(f,x,y+1,n,w) * row, {});

    // The removed half-open row segment [2y,x) has x-2y points
  RowSegmentCardinality(2*y,x,y);

    // Since the two parts are disjoint, their cardinalities add up to
    // the cardinality of the original set
  DisjointUnionCardinality(MatchingSet(f,x,y+1,n,w), row);
}

//========================================================================
// Counts the matching points by repeatedly removing either the rightmost
// column or the bottommost row of the remaining triangle.
method problem16(f:(nat,nat) -> int, n:nat, w:int)
returns (z:int)
requires Ordered2DNat(f, Asc, Asc)
ensures z == |MatchingSet(f,n,0,n,w)|
{
  var x:nat, y:nat := n,0;
  z := 0;

  while x > 0 && y < n && 2*y < x
    invariant x <= n && y <= n
      // z stores the number of matching points that have been counted 
      // so far, while MatchingSet(f,x,y,n,w) counts the matching points
      // in the remaining triangular region. The sum of these two counts
      // is the total number of matching points in the initial triangular
      // region.
    invariant z + |MatchingSet(f,x,y,n,w)| == |MatchingSet(f,n,0,n,w)|
    decreases x + (n - y)
  {
    if f(x-1,y) >= w 
    {
      DiscardColumn(f,x,y,n,w);
      x := x - 1;
    } 
    
    else 
    {
      AdvanceRow(f,x,y,n,w);
      z := z + (x - 2*y);
      y := y + 1;
    }
  }

    // At this point, the remaining triangular region is empty 
    // (|MatchingSet(f,x,y,n,w)| = 0), so the loop invariant implies 
    // that the total number of matching points is exactly z.
  EmptySet(f,x,y,n,w);
}
