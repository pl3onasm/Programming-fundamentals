/*  file: sol06Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob06
    This is exercise 9.7 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../FormalSupport.dfy"
include "../../commonSupport.dfy"
import opened FormalSupport
import opened MonotonicityProps
import opened CommonFunctions

//========================================================================
// Represents the matching points in the remaining triangular search
// region bounded on the left by i = x, below by j = y, and above by
// the diagonal i + j = n.
// The explicit bounds i < n and j < n are implied by i + j < n,
// but make the finiteness of the set explicit to Dafny.
ghost function MatchingSet(g:(nat,nat) -> int, x:nat, y:nat, 
                           n:nat, w:int): set<(nat,nat)>
{
  set i:nat, j:nat |
       x <= i < n && y <= j < n && i + j < n && g(i,j) == w
    :: (i,j)
}

//========================================================================
// If the south-west corner lies on or above i + j = n, then the remaining
// triangular search region is empty, so the set of remaining matching
// points is empty as well.
lemma EmptySet(g:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int)
  requires x + y >= n
  ensures MatchingSet(g,x,y,n,w) == {}
{
  Set2DEquality(MatchingSet(g,x,y,n,w),{});
}

//========================================================================
// If g(x,y) < w, descending order in g's second argument implies
// g(x,j) ≤ g(x,y) < w for every remaining index j >= y. Hence the
// part of the leftmost column that lies inside the triangular search
// region contains no matching points. Removing that column therefore
// leaves MatchingSet unchanged.
lemma DiscardColumn(g:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int)
  requires Ordered2DNat(g, Incr, Desc)
  requires x + y < n
  requires g(x,y) < w
  ensures MatchingSet(g,x,y,n,w) ==
          MatchingSet(g,x+1,y,n,w)
{
  Set2DEquality(MatchingSet(g,x,y,n,w), MatchingSet(g,x+1,y,n,w));
}

//========================================================================
// If g(x,y) ≥ w, strict increase in g's first argument implies that
// g(i,y) > g(x,y) ≥ w for every remaining index i > x. Therefore,
// (x,y) is the only possible matching point in the bottom row.
// Removing that row decreases the remaining count by 1 exactly when
// g(x,y) = w.
lemma AdvanceRow(g:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int)
  requires Ordered2DNat(g, Incr, Desc)
  requires x + y < n
  requires g(x,y) >= w
  ensures |MatchingSet(g,x,y,n,w)| ==
          |MatchingSet(g,x,y+1,n,w)| + ord(g(x,y) == w)
{   
    // After removing the only possible matching point (x,y), the
    // remaining set is exactly the matching set obtained by advancing
    // the lower row boundary from y to y + 1
  Set2DEquality(MatchingSet(g,x,y,n,w) - {(x,y)}, 
                MatchingSet(g,x,y+1,n,w));
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost
// column or the bottommost row of the remaining triangular search region.
method problem06(g:(nat,nat) -> int, n:nat, w:int)
returns  (z:int)
requires Ordered2DNat(g, Incr, Desc)
ensures  z == |MatchingSet(g,0,0,n,w)|
{
  var x:nat, y:nat := 0,0;
  z := 0;

  while x + y < n
      // z stores the number of matching points already removed and
      // counted, while MatchingSet(g,x,y,n,w) contains the matching
      // points that remain in the current triangular search region.
      // Together, these counts equal the number of matches in the
      // initial triangular domain.
    invariant z + |MatchingSet(g,x,y,n,w)| == |MatchingSet(g,0,0,n,w)|
    decreases n - (x + y)
  {
    if g(x,y) < w 
    {
      DiscardColumn(g,x,y,n,w);
      x := x+1;
    } 
    
    else 
    {
      AdvanceRow(g,x,y,n,w);
      z := z + ord(g(x,y) == w);
      y := y+1;
    }
  }

    // After the loop, x + y ≥ n, so the south-west corner lies on or
    // above the diagonal boundary. The remaining triangular region is
    // therefore empty, and the cardinality invariant implies that z is
    // the complete number of matching points.
  EmptySet(g,x,y,n,w);
}
