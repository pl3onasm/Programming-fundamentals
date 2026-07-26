/*  file: sol07Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob07
    This is exercise 9.8 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../FormalSupport.dfy"
include "../../commonSupport.dfy"
import opened FormalSupport
import opened MonotonicityProps

//========================================================================
// Represents the matching points in the remaining rectangle [x,n) × [0,y)
// that also lie below the diagonal i + j = n and satisfy h(i,j) > 0
ghost function MatchingSet(h:(nat,nat) -> int, x:nat, y:nat, 
                           n:nat): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i < n && j < y && i + j < n && h(i,j) > 0
    :: (i,j)
}

//========================================================================
// If x ≥ n or y = 0, the remaining rectangle is empty and so the set of
// remaining matching points is empty as well.
lemma EmptySet(h:(nat,nat) -> int, x:nat, y:nat, n:nat)
  requires x >= n || y == 0
  ensures  MatchingSet(h,x,y,n) == {}
{
  Set2DEquality(MatchingSet(h,x,y,n), {});
}

//========================================================================
// If h(x,y-1) ≤ 0, ascending order in h's second argument implies
// h(x,j) ≤ h(x,y-1) ≤ 0 for every 0 ≤ j < y. Hence the entire
// leftmost column contains no matching point. Removing that column
// therefore leaves MatchingSet unchanged.
lemma DiscardColumn(h:(nat,nat) -> int, x:nat, y:nat, n:nat)
  requires Ordered2DNat(h, Asc, Asc)
  requires x < n && y > 0
  requires h(x,y-1) <= 0
  ensures  MatchingSet(h,x,y,n) == MatchingSet(h,x+1,y,n)
{
  Set2DEquality(MatchingSet(h,x,y,n), MatchingSet(h,x+1,y,n));
}

//========================================================================
// If h(x,y-1) > 0 and the top row lies (partially) below the diagonal,
// ascending order in h's first argument implies that every point in the
// row segment [x,n-y+1) is a matching point, and its size can be added 
// to the overall count of matching points.
lemma CountRow(h:(nat,nat) -> int, x:nat, y:nat, n:nat)
  requires Ordered2DNat(h, Asc, Asc)
  requires x < n && y > 0
  requires x + y <= n
  requires h(x,y-1) > 0
  ensures |MatchingSet(h,x,y,n)| 
       == |MatchingSet(h,x,y-1,n)| + n - x - y + 1
{
  var row := RowSegment(x,n-y+1,y-1);

    // In the topmost row j = y - 1, the diagonal condition becomes
    // i + y - 1 < n, or i < n - y + 1. Hence the row segment contains
    // exactly the points with x <= i < n - y + 1.

    // Since h is ascending in its first argument and h(x,y-1) > 0,
    // every point in this row segment also satisfies h(i,y-1) > 0
    // and is therefore a matching point. Thus, the current matching 
    // set equals the union of the remaining matching set and the row 
    // segment.
  Set2DEquality(MatchingSet(h,x,y,n), MatchingSet(h,x,y-1,n) + row);

    // The two sets are disjoint: the segment contains points whose 
    // second coordinate is exactly y-1, whereas MatchingSet(h,x,y-1,n)
    // contains only points with second coordinate below y-1
  Set2DEquality(MatchingSet(h,x,y-1,n) * row, {});

    // The size of the half-open segment [x,n-y+1) is (n-y+1) - x
  RowSegmentCardinality(x,n-y+1,y-1);

    // Thus the cardinality of the current matching set is the sum
    // of the remaining cardinality and the size of the removed segment
  DisjointUnionCardinality(MatchingSet(h,x,y-1,n), row);
}

//========================================================================
// If x + y > n, then for every remaining index i ≥ x, i + y > n and 
// hence i + (y-1) ≥ n. Therefore no point in the topmost row j = y-1 
// lies below the diagonal i + j = n. Thus, removing that row leaves 
// MatchingSet unchanged.
lemma DiscardRow(h:(nat,nat) -> int, x:nat, y:nat, n:nat)
  requires x < n && y > 0
  requires x + y > n
  ensures  MatchingSet(h,x,y,n) == MatchingSet(h,x,y-1,n)
{
  Set2DEquality(MatchingSet(h,x,y,n),
                MatchingSet(h,x,y-1,n));
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost
// column or the topmost row of the remaining rectangle.
method problem07(h:(nat,nat) -> int, n:nat)
returns  (z:int)
requires Ordered2DNat(h, Asc, Asc)
ensures  z == |MatchingSet(h,0,n,n)|
{
  var x:nat, y:nat := 0,n;
  z := 0;

  while x < n && y > 0
    invariant x <= n && y <= n
      // The program variable z stores the number of matching points
      // already removed and counted, while MatchingSet(h,x,y,n)
      // contains the matching points that remain in the current search
      // window. Their total equals the number of matching points in the
      // original triangular domain i + j < n.
    invariant z + |MatchingSet(h,x,y,n)| == |MatchingSet(h,0,n,n)|
    decreases n - x + y
  {
    if h(x,y-1) <= 0 
    {
      DiscardColumn(h,x,y,n);
      x := x + 1;
    } 
    
    else 
    {
      if x + y <= n 
      {
        CountRow(h,x,y,n);
        z := z + n - x - y + 1;
      } 
      else 
      {
        DiscardRow(h,x,y,n);
      }
      y := y - 1;
    }
  }

    // After the loop, either x ≥ n or y = 0. Thus, the remaining 
    // rectangle has zero width or zero height, so MatchingSet is empty.
    // The cardinality invariant then implies that z is the complete
    // number of matching points in the original triangular domain.
  EmptySet(h,x,y,n);
}
