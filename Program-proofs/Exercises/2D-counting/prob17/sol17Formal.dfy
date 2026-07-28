/*  file: sol17Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob17
    This is exercise 9.19 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

//========================================================================
// States that z is the minimum value i+j among the matching points in the
// rectangle [0,m) x [0,n). If there is no matching point, z is the
// sentinel value m + n.
// IsCandidateOrSentinel establishes that z is either an actual candidate
// value or the sentinel. With x = m and y = 0, the remaining rectangle is
// empty, so BoundsDiscarded establishes that z bounds from below every
// candidate value in the original rectangle.
ghost predicate Minimum(h:(nat,nat) -> int, m:nat, n:nat, w:int, z:int)
{
  IsCandidateOrSentinel(h,m,n,w,z) && BoundsDiscarded(h,m,n,m,0,w,z)
}

//========================================================================
// States that z is either the sentinel value m + n or the value i + j of 
// a matching point in the original rectangle [0,m) x [0,n). 
ghost predicate IsCandidateOrSentinel(h:(nat,nat) -> int, m:nat, n:nat,
                                      w:int, z:int)
{
  z == m + n ||
  exists i:nat, j:nat :: i < m && j < n && h(i,j) > w && z == i + j
}

//========================================================================
// States that z is a lower bound on all candidate values i + j that have
// already been removed from the search area and lie outside the remaining
// rectangle [x,m) x [0,y).
ghost predicate BoundsDiscarded(h:(nat,nat) -> int, m:nat, n:nat,
                                x:nat, y:nat, w:int, z:int)
{
  forall i:nat, j:nat ::
    i < m && j < n && (i < x || y <= j) && h(i,j) > w ==> z <= i + j
}

//========================================================================
// If h(x,y-1) ≤ w, ascending order in h's second argument implies that
// h(x,j) ≤ h(x,y-1) ≤ w for every 0 ≤ j < y. Hence the leftmost
// column contains no matching point. Removing that column therefore
// extends BoundsDiscarded without changing z.
lemma DiscardColumn(h:(nat,nat) -> int, m:nat, n:nat, x:nat, y:nat,
                    w:int, z:int)
  requires Ordered2DNat(h, Asc, Asc)
  requires x < m && 0 < y <= n
  requires h(x,y-1) <= w
  requires BoundsDiscarded(h,m,n,x,y,w,z)
  ensures  BoundsDiscarded(h,m,n,x+1,y,w,z)
{
}

//========================================================================
// If h(x,y-1) > w, ascending order in h's first argument implies that the
// whole top row is matching. The smallest candidate value in that row is
// x + y - 1, attained at the north-west corner. Updating z with this 
// value extends both IsCandidateOrSentinel and BoundsDiscarded to the 
// newly removed row.
lemma DiscardRow(h:(nat,nat) -> int, m:nat, n:nat, x:nat, y:nat,
                 w:int, z:int)
  requires Ordered2DNat(h, Asc, Asc)
  requires x < m && 0 < y <= n
  requires h(x,y-1) > w
  requires IsCandidateOrSentinel(h,m,n,w,z)
  requires BoundsDiscarded(h,m,n,x,y,w,z)
  ensures  IsCandidateOrSentinel(h,m,n,w,minimum(z,x+y-1))
  ensures  BoundsDiscarded(h,m,n,x,y-1,w,minimum(z,x+y-1))
{
}

//========================================================================
// Once the remaining rectangle is empty, every point in the original
// rectangle now belongs to the discarded region. BoundsDiscarded shows
// that z bounds every candidate value from below, while
// IsCandidateOrSentinel shows that z is either attained by a matching
// point or is the sentinel value. Together, these properties establish
// Minimum(h,m,n,w,z), the postcondition of the main method.
lemma Finish(h:(nat,nat) -> int, m:nat, n:nat, x:nat, y:nat, w:int, z:int)
  requires x <= m && y <= n
  requires x == m || y == 0
  requires IsCandidateOrSentinel(h,m,n,w,z)
  requires BoundsDiscarded(h,m,n,x,y,w,z)
  ensures  Minimum(h,m,n,w,z)
{
}

//========================================================================
// Computes the minimum value i + j among the points satisfying h(i,j) > w
// in the rectangle [0,m) x [0,n). If no such point exists, the sentinel
// value m + n is returned.
method problem17(h:(nat,nat) -> int, m:nat, n:nat, w:int)
returns  (z:int)
requires Ordered2DNat(h, Asc, Asc)
ensures  Minimum(h,m,n,w,z)
{
  var x:nat, y:nat := 0,n;
    // z is initialized to the sentinel value m + n. Since every actual
    // candidate value i + j is strictly smaller than m + n, this value
    // represents the result when no matching point exists.
  z := m + n;

  while x < m && y > 0
    invariant x <= m && y <= n
      // The program variable z is either the sentinel or the value 
      // of an actual matching point, and it bounds from below all 
      // candidate values already removed from the search area.
    invariant IsCandidateOrSentinel(h,m,n,w,z)
    invariant BoundsDiscarded(h,m,n,x,y,w,z)
    decreases (m - x) + y
  {
    if h(x,y-1) <= w
    {
      DiscardColumn(h,m,n,x,y,w,z);
      x := x + 1;
    }

    else
    {
      DiscardRow(h,m,n,x,y,w,z);
      z := minimum(z, x + y - 1);
      y := y - 1;
    }
  }

    // After the loop, the remaining rectangle is empty. Thus all
    // candidate values have been removed and are bounded from below 
    // by z. Since z is either the sentinel value or the value i + j of
    // a matching point in the original rectangle, Finish establishes
    // the postcondition Minimum(h,m,n,w,z) of the main method.
  Finish(h,m,n,x,y,w,z);
}
