/*  file: sol15Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob15
    This is exercise 9.17 from the PC reader
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
// Represents the set of matching points (i,j) in the remaining search
// region inside the quarter disk i² + j² < p.
// For the initial call, the explicit coordinate bounds i < p and j < p
// are redundant, since they are implied by i² + j² < p. They are,
// however, useful for making finiteness explicit when representing the
// specification as a finite set in Dafny.
ghost function MatchingSet(h:(nat,nat) -> int, x:nat, y:nat, p:nat,
                           w:int): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i < p && y <= j < p &&
                     i*i + j*j < p && h(i,j) == w
    :: (i,j)
}

//========================================================================
// If a coordinate has reached p, or the south-west corner of the
// remaining search region lies on or outside the circular boundary
// i² + j² = p, then the set of matching points in the remaining search 
// region is empty.
lemma EmptySet(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int)
  requires x == p || y == p || x*x + y*y >= p
  ensures MatchingSet(h,x,y,p,w) == {}
{
  forall i:nat, j:nat
    ensures (i,j) in MatchingSet(h,x,y,p,w) <==> false
  {
    if (i,j) in MatchingSet(h,x,y,p,w) 
    {
        // Membership gives x ≤ i and y ≤ j. Hence i² + j² is
        // at least x² + y², which is at least p (by the precondition),
        // contradicting membership in the disk.
      SquareMonotone(x,i);   // x ≤ i implies x² ≤ i²
      SquareMonotone(y,j);   // y ≤ j implies y² ≤ j²
    }
  }
}

//========================================================================
// If h(x,y) < w, strict decrease in h's second argument implies that
// the part of the leftmost remaining column lying inside the quarter
// disk contains no matching point. Removing that column therefore
// leaves the set of remaining matches unchanged.
lemma DiscardColumn(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int)
  requires Ordered2DNat(h, Incr, Decr)
  requires h(x,y) < w
  ensures MatchingSet(h,x,y,p,w) == MatchingSet(h,x+1,y,p,w)
{
  Set2DEquality(MatchingSet(h,x,y,p,w), 
                MatchingSet(h,x+1,y,p,w));
}

//========================================================================
// If h(x,y) ≥ w, strict increase in h's first argument implies that
// (x,y) is the only possible matching point in the bottommost part of
// the remaining quarter-disk region. It is counted when h(x,y) == w,
// after which the rest of that row can be removed.
lemma AdvanceRow(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int)
  requires Ordered2DNat(h, Incr, Decr)
  requires x*x + y*y < p
  requires h(x,y) >= w
  ensures    |MatchingSet(h,x,y,p,w)| 
          == |MatchingSet(h,x,y+1,p,w)| + ord(h(x,y) == w)
{
    // Removing the possible matching corner leaves exactly the set
    // obtained by advancing the lower boundary to the next row.
  Set2DEquality(MatchingSet(h,x,y,p,w) - {(x,y)},
                MatchingSet(h,x,y+1,p,w));
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost
// column or the bottommost row of the remaining quarter-disk region.
method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z:int)
requires Ordered2DNat(h, Incr, Decr)
ensures z == |MatchingSet(h,0,0,p,w)|
{
  var x:nat, y:nat := 0,0;
  z := 0;

  while x*x + y*y < p
    invariant x <= p && y <= p
      // z stores the number of matching points already counted, while
      // MatchingSet(h,x,y,p,w) contains the matching points that remain
      // in the current quarter-disk search region. Together, these
      // counts equal the number of matches in the initial quarter disk.
    invariant z + |MatchingSet(h,x,y,p,w)| 
              ==  |MatchingSet(h,0,0,p,w)|
    decreases (p - x) + (p - y)
  {
    if h(x,y) < w 
    {
      DiscardColumn(h,x,y,p,w);
      x := x + 1;
    } 
    
    else 
    {
      AdvanceRow(h,x,y,p,w);
      z := z + ord(h(x,y) == w);
      y := y + 1;
    }
  }

    // The negated guard places the south-west corner on or outside the
    // circular boundary, so the set of remaining matching points is 
    // empty. The cardinality invariant then implies that the total count
    // of matching points is complete in z.
  EmptySet(h,x,y,p,w);
}