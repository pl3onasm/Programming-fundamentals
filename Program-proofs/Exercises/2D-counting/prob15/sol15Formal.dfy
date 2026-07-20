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
// Represents the set of matching points (i,j) in the remaining
// rectangle [x,p) × [y,p), restricted to the quarter disk i² + j² < p.
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
// remaining rectangle lies outside the disk, the remaining set is empty.
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
// If h(x,y) < w, strict decrease in the second argument implies that the 
// entire leftmost column contains no matching points and can be discarded
// from the total count.
lemma DiscardColumn(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int)
  requires Ordered2DNat(h, Incr, Decr)
  requires h(x,y) < w
  ensures MatchingSet(h,x,y,p,w) == MatchingSet(h,x+1,y,p,w)
{
  Set2DEquality(MatchingSet(h,x,y,p,w), 
                MatchingSet(h,x+1,y,p,w));
}

//========================================================================
// If h(x,y) ≥ w, strict increase in the first argument implies that (x,y) 
// is the only possible matching point in the bottom row, and can be 
// counted if h(x,y) == w, after which the entire bottom row can be 
// discarded from the total count.
lemma AdvanceRow(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int)
  requires Ordered2DNat(h, Incr, Decr)
  requires x*x + y*y < p
  requires h(x,y) >= w
  ensures    |MatchingSet(h,x,y,p,w)| 
          == |MatchingSet(h,x,y+1,p,w)| + ord(h(x,y) == w)
{
    // Removing the possible matching corner leaves exactly the set
    // obtained by advancing to the next row.
  Set2DEquality(MatchingSet(h,x,y,p,w) - {(x,y)},
                MatchingSet(h,x,y+1,p,w));
}

//========================================================================
// The main counting method, computed iteratively by removing either 
// the leftmost column or the bottommost row.
method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z:int)
requires Ordered2DNat(h, Incr, Decr)
ensures z == |MatchingSet(h,0,0,p,w)|
{
  var x:nat, y:nat := 0,0;
  z := 0;

  while x*x + y*y < p
    invariant x <= p && y <= p
      // z holds the number of matching points already counted, while 
      // MatchingSet(h,x,y,p,w) counts the matching points in the 
      // remaining search region. The sum of these two counts is the
      // total number of matching points in the initial search region.
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

    // The negated guard ensures that the remaining search region is 
    // empty, so that no further matching points remain in the search 
    // region and the total count is complete in z.
  EmptySet(h,x,y,p,w);
}