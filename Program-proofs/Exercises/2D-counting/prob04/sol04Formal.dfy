/*  file: sol04Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob04
    This is exercise 9.5 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"
include "../../Support/Sets.dfy"

import opened MonotonicityProps
import opened MathSupport
import opened SetSupport

//========================================================================
// Represents the matching points in the remaining rectangle
// [x,m) × [0,y). The first coordinate i ranges over the remaining
// columns, while the second coordinate j ranges over the remaining rows.
ghost function MatchingSet(g:(int,int) -> int, x:nat, y:nat, 
                           m:nat): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i < m && j < y && g(i,j) == j :: (i,j)
}

//========================================================================
// Strict increase of an integer-valued function raises its value by at
// least one at each step in the second argument. Hence moving from j
// to k increases the value by at least k-j.
lemma SecondGrowth(g:(int,int) -> int, i:int, j:int, k:int)
  requires  Ordered2DInt(g, Incr, Incr)
  requires  j <= k
  ensures   g(i,j) + (k - j) <= g(i,k)
  decreases k - j
{
  if j < k
  {
      // Apply the induction hypothesis up to k-1. Strict increase from
      // k-1 to k then adds at least one more to the lower bound.
    SecondGrowth(g,i,j,k-1);
  }
}

//========================================================================
// If the rectangle has zero width or zero height, then the set of 
// remaining matching points is empty.
lemma EmptySet(g:(int,int) -> int, x:nat, y:nat, m:nat)
  requires x >= m || y == 0
  ensures  MatchingSet(g,x,y,m) == {}
{
  Set2DEquality(MatchingSet(g,x,y,m), {});
}

//========================================================================
// If g(x,y-1) < y-1, strict increase in g's second argument implies
// that g(x,j) < j for every 0 ≤ j < y. Hence the entire leftmost
// column contains no matching point. Removing that column therefore
// leaves MatchingSet unchanged.
lemma DiscardColumn(g:(int,int) -> int, x:nat, y:nat, m:nat)
  requires Ordered2DInt(g, Incr, Incr)
  requires x < m && y > 0
  requires g(x,y-1) < y-1
  ensures  MatchingSet(g,x,y,m) == MatchingSet(g,x+1,y,m)
{
  forall j:nat | j < y
    ensures g(x,j) != j
  {
      // Moving from j to y-1 raises g by at least y-1-j. 
      // Since g(x,y-1) < y-1, it follows that g(x,j) < j.
    SecondGrowth(g,x,j,y-1);
  }
    
    // The current matching set is the same as the matching set with
    // the leftmost column removed, since that column contains no
    // matching points.
  Set2DEquality(MatchingSet(g,x,y,m), MatchingSet(g,x+1,y,m));
}

//========================================================================
// If g(x,y-1) ≥ y-1, strict increase in g's first argument implies
// that g(i,y-1) > y-1 for every remaining index i > x. Therefore,
// (x,y-1) is the only possible matching point in the topmost row.
// Removing that row reduces the remaining count by 1 exactly when
// g(x,y-1) = y-1; otherwise it leaves the count unchanged.
lemma AdvanceRow(g:(int,int) -> int, x:nat, y:nat, m:nat)
  requires Ordered2DInt(g, Incr, Incr)
  requires x < m && y > 0
  requires g(x,y-1) >= y-1
  ensures |MatchingSet(g,x,y,m)| ==
          |MatchingSet(g,x,y-1,m)| + ord(g(x,y-1) == y-1)
{
    // After removing the only possible matching point (x,y-1), the
    // remaining set is exactly the matching set obtained by lowering
    // the upper row boundary from y to y-1.
  Set2DEquality(MatchingSet(g,x,y,m) - {(x,y-1)}, MatchingSet(g,x,y-1,m));
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost
// column or the topmost row of the remaining rectangular search region.
method problem04(g:(int,int) -> int, m:nat, n:nat)
returns  (z:int)
requires Ordered2DInt(g, Incr, Incr)
ensures  z == |MatchingSet(g,0,n,m)|
{
  var x:nat, y:nat := 0,n;
  z := 0;

  while x < m && y > 0
      // z stores the number of matching points already removed and
      // counted, while MatchingSet(g,x,y,m) contains the matching
      // points that remain in the current rectangle. Together, these
      // counts equal the number of matches in the initial rectangle.
    invariant z + |MatchingSet(g,x,y,m)| == |MatchingSet(g,0,n,m)|
    decreases (m - x) + y
  {
    if g(x,y-1) < y - 1 
    {
      DiscardColumn(g,x,y,m);
      x := x + 1;
    } 
    
    else 
    {
      AdvanceRow(g,x,y,m);
      z := z + ord(g(x,y-1) == y - 1);
      y := y - 1;
    }
  }

    // After the loop, either x ≥ m or y = 0. The remaining rectangle
    // therefore has zero width or zero height, so MatchingSet is empty.
    // The cardinality invariant then implies that z is the complete
    // number of matching points.
  EmptySet(g,x,y,m);
}
