/*  file: sol19Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob19
    This is exercise 9.21 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the Exercises folder)
*/

include "../../FormalSupport.dfy"
include "../../commonSupport.dfy"
import opened FormalSupport
import opened MonotonicityProps
import opened CommonFunctions

//========================================================================
// Defines a finite strict upper bound on the second coordinate of every
// matching point. Under the monotonicity assumptions used below, h(0,0)
// is the smallest grid value. The bound is obtained from the value gap
// between h(0,0) and the target value c and made strict by adding 1. 
ghost function UpperBound(h:(nat,nat) -> int, c:int): nat
{
  if h(0,0) <= c then c - h(0,0) + 1 else 0
}

//========================================================================
// Represents the matching points in the remaining semi-infinite strip.
// The explicit upper bound on j gives Dafny a finite representation of
// the otherwise semi-infinite search region, allowing its cardinality 
// to be used. The lemma MatchingUpperBound proves that this cutoff 
// excludes no actual matching point.
ghost function MatchingSet(h:(nat,nat) -> int, x:nat, 
                           y:nat, c:int): set<(nat,nat)>
{
  set i:nat, j:nat | i < x && y <= j < UpperBound(h,c) && h(i,j) == c
    :: (i,j)
}

//========================================================================
// Strict increase in the second argument implies that h(i,j) grows at 
// least linearly with j for any fixed i. 
// NOTE: The lemma is proved by induction on j. The recursive call
// supplies the induction hypothesis for j-1. Strict increase between
// the consecutive positions j-1 and j then contributes at least one
// additional integer unit.
lemma SecondGrowth(h:(nat,nat) -> int, i:nat, j:nat)
  requires Ordered2DNat(h, Asc, Incr)
  ensures h(i,0) + j <= h(i,j)
  decreases j
{
  if j > 0 
  {
      // The recursive call yields the induction hypothesis 
      // h(i,0) + (j-1) <= h(i,j-1)
    SecondGrowth(h,i,j-1);

      // Strict increase over integer values implies an increase
      // of at least one
    assert h(i,j-1) + 1 <= h(i,j);

    calc 
    {
      h(i,0) + j;
      == h(i,0) + (j-1) + 1;
      <= h(i,j-1) + 1;         // induction hypothesis
      <= h(i,j);               // strict integer increase
    }
  }

  // The base case j == 0 trivially satisfies h(i,0) + 0 <= h(i,0)
}

//========================================================================
// Proves that every matching point lies below the finite bound
// UpperBound(h,c). Consequently, the finite set MatchingSet excludes
// no matching point from the original semi-infinite strip.
lemma MatchingUpperBound(h:(nat,nat) -> int, i:nat, j:nat, c:int)
  requires Ordered2DNat(h, Asc, Incr)
  requires h(i,j) == c
  ensures j < UpperBound(h,c)
{
    // Ascending order in the first argument gives h(0,0) <= h(i,0)
  assert h(0,0) <= h(i,0);

    // Strict increase in the second argument gives h(i,0) + j <= h(i,j)
  SecondGrowth(h,i,j);

  calc {
    h(0,0) + j;
    <= h(i,0) + j;      // see assertion above
    <= h(i,j);          // see SecondGrowth lemma
    == c;               // see precondition
  }

    // Hence we have h(0,0) <= c, and UpperBound uses its first branch.
  assert h(0,0) <= c;
  assert UpperBound(h,c) == c - h(0,0) + 1;

    // From h(0,0) + j <= c, we obtain
    // j <= c-h(0,0), and therefore j < UpperBound(h,c)
  assert j <= c - h(0,0);
  assert j < UpperBound(h,c);
}

//========================================================================
// If the horizontal range has reached zero, there are no remaining 
// matching points in the semi-infinite strip.
lemma EmptySet(h:(nat,nat) -> int, x:nat, y:nat, c:int)
  requires x == 0
  ensures MatchingSet(h,x,y,c) == {}
{
  Set2DEquality(MatchingSet(h,x,y,c), {});
}

//========================================================================
// If h(x-1,y) < c, ascending order in the first argument implies that
// the entire current row contains no matching point.
lemma DiscardRow(h:(nat,nat) -> int, x:nat, y:nat, c:int)
  requires Ordered2DNat(h, Asc, Incr)
  requires x > 0
  requires h(x-1,y) < c
  ensures MatchingSet(h,x,y,c) == MatchingSet(h,x,y+1,c)
{
    // The current row contains only points (i,y) with i < x, and for
    // each of those points, h(i,y) ≤ h(x-1,y) < c, so none of them can 
    // be a matching point. Thus the matching set remains unchanged if  
    // we move north to the next row.
  Set2DEquality(MatchingSet(h,x,y,c), MatchingSet(h,x,y+1,c));
}

//========================================================================
// If h(x-1,y) >= c, strict increase in the second argument implies that
// (x-1,y) is the only possible matching point in the rightmost column.
lemma DiscardColumn(h:(nat,nat) -> int, x:nat, y:nat, c:int)
  requires Ordered2DNat(h, Asc, Incr)
  requires x > 0
  requires h(x-1,y) >= c
  ensures |MatchingSet(h,x,y,c)| 
       == |MatchingSet(h,x-1,y,c)| + ord(h(x-1,y) == c)
{
  if h(x-1,y) == c 
  {
      // The current point is a match. MatchingUpperBound proves that
      // it lies inside the finite representation of the strip.
    MatchingUpperBound(h,x-1,y,c);
    assert y < UpperBound(h,c);
    assert (x-1,y) in MatchingSet(h,x,y,c);
  }

    // Removing the possible point (x-1,y) leaves exactly the smaller
    // semi-infinite strip with the rightmost column removed. If the
    // point is a match, the cardinality decreases by one; otherwise,
    // it remains unchanged.
  Set2DEquality(MatchingSet(h,x,y,c) - {(x-1,y)}, MatchingSet(h,x-1,y,c));
}

//========================================================================
// Measures the remaining value gap between the current point and the 
// target value c.
ghost function Gap(h:(nat,nat) -> int, x:nat, y:nat, c:int): nat
{
  if x > 0 && h(x-1,y) < c then c - h(x-1,y) else 0
}

//========================================================================
// Counts all matching points by repeatedly moving north or west.
method problem19(h:(nat,nat) -> int, n:nat, c:int)
returns (z:int)
requires Ordered2DNat(h, Asc, Incr)
requires c < h(n,0)
ensures z == |MatchingSet(h,n,0,c)|
{
  var x:nat, y:nat := n,0;
  z := 0;

  while x > 0
    invariant x <= n
      // z stores the number of matching points already counted, while
      // |MatchingSet(h,x,y,c)| represents the number of remaining points
      // in the current semi-infinite strip. Their sum is the total number
      // of matching points in the original semi-infinite strip.
    invariant z + |MatchingSet(h,x,y,c)| == |MatchingSet(h,n,0,c)|
    decreases x, Gap(h,x,y,c)
  {
    if h(x-1,y) < c 
    {
      DiscardRow(h,x,y,c);
      y := y+1;
    } 
    
    else 
    {
      DiscardColumn(h,x,y,c);
      z := z + ord(h(x-1,y) == c);
      x := x-1;
    }
  }
    
    // When the horizontal range reaches zero, no matching points remain
    // in the semi-infinite strip. The loop invariant then implies that
    // z contains the complete count.
  EmptySet(h,x,y,c);
}
