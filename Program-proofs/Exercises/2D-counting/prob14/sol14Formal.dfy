/*  file: sol14Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob14
    This is exercise 9.16a from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

//========================================================================
// States that z is the maximum candidate product (i+1)*(j+1) over all
// points in [0,m) × [0,n) for which h(i,j) > 0. IsCandidate states that
// z is either the sentinel value 0 or the product of an actual positive
// point. With x = m and y = 0, the remaining rectangle is empty, so
// BoundsDiscarded states that z is an upper bound on every positive
// candidate product in the original rectangle.
ghost predicate Maximum(h:(nat,nat) -> int, m:nat, n:nat, z:int)
{
  IsCandidate(h,m,n,z) && BoundsDiscarded(h,m,n,m,0,z)
}

//========================================================================
// z is either the sentinel value 0 or the product of an actual
// positive point encountered by the search.
ghost predicate IsCandidate(h:(nat,nat) -> int, m:nat, n:nat, z:int)
{
  z == 0 || exists i:nat, j:nat :: i < m && j < n && h(i,j) > 0 &&
                                   z == (i+1)*(j+1)
}

//========================================================================
// The value of z is an upper bound on the products of all positive points 
// that have already been removed from the search area and lie outside the 
// remaining rectangle [x,m) × [0,y). 
ghost predicate BoundsDiscarded(h:(nat,nat) -> int, m:nat, n:nat,
                                x:nat, y:nat, z:int)
{
  forall i:nat, j:nat :: i < m && j < n && (i < x || y <= j) && h(i,j) > 0
                         ==> (i+1)*(j+1) <= z
}

//========================================================================
// Updating z with the product of a positive point preserves the property
// that z is either 0 or the product of an actual positive point in the
// original rectangle.
lemma UpdateCandidate(h:(nat,nat) -> int, m:nat, n:nat, 
                      z:int, i:nat, j:nat)
  requires IsCandidate(h,m,n,z)
  requires i < m && j < n && h(i,j) > 0
  ensures IsCandidate(h,m,n, maximum(z,(i+1)*(j+1)))
{
}

//========================================================================
// If the top of the leftmost column is positive, descending order in the
// second argument implies that the entire column is positive. The largest
// product in that column is attained at (x,y-1), because the first 
// coordinate is fixed at x, and y-1 is its largest row index. Updating z 
// with (x+1)*y therefore extends BoundsDiscarded to include the newly 
// removed column. Dafny verifies the postcondition directly from the 
// definitions and preconditions. Adding an explicit quantified proof body
// is possible but unnecessary. Because it causes excessive verification
// time, it is omitted here.
lemma CountColumn(h:(nat,nat) -> int, m:nat, n:nat, x:nat, y:nat, z:int)
  requires Ordered2DNat(h, Desc, Desc)
  requires x < m && 0 < y <= n
  requires h(x,y-1) > 0
  requires BoundsDiscarded(h,m,n,x,y,z)
  ensures  BoundsDiscarded(h,m,n,x+1,y,maximum(z,(x+1)*y))
{ 
}

//========================================================================
// If the top-left corner is non-positive, descending order in the first
// argument implies that every point in the top row is non-positive.
// The row therefore contains no candidate point and can be discarded
// without changing z. Dafny verifies the postcondition directly from the
// definitions and preconditions. Adding an explicit quantified proof body
// is possible but unnecessary. Because it causes excessive verification
// time, it is omitted here.
lemma DiscardRow(h:(nat,nat) -> int, m:nat, n:nat, x:nat, y:nat, z:int)
  requires Ordered2DNat(h, Desc, Desc)
  requires x < m && 0 < y <= n
  requires h(x,y-1) <= 0
  requires BoundsDiscarded(h,m,n,x,y,z)
  ensures  BoundsDiscarded(h,m,n,x,y-1,z)
{
}

//========================================================================
// Once the remaining rectangle is empty, every point in the original
// rectangle belongs to the discarded region. BoundsDiscarded therefore
// shows that z bounds every positive candidate product from above, while 
// IsCandidate shows that z is either 0 or is attained by an actual 
// positive point. Together, these properties establish Maximum(h,m,n,z),  
// the postcondition of the main method. Dafny derives this implication 
// directly from the predicate definitions and the preconditions.
lemma Finish(h:(nat,nat) -> int, m:nat, n:nat, x:nat, y:nat, z:int)
  requires x <= m && y <= n
  requires x == m || y == 0
  requires IsCandidate(h,m,n,z)
  requires BoundsDiscarded(h,m,n,x,y,z)
  ensures Maximum(h,m,n,z)
{
}

//========================================================================
// Finds the maximum product by repeatedly removing either the leftmost
// column or the topmost row of the remaining rectangle.
method problem14(h:(nat,nat) -> int, m:nat, n:nat)
returns (z:int)
requires Ordered2DNat(h, Desc, Desc)
ensures Maximum(h,m,n,z)
{
  var x:nat, y:nat := 0,n;
  z := 0;

  while x < m && y > 0
    invariant x <= m && y <= n
      // z is either 0 or an attained candidate, and it is an upper bound 
      // on the products of all positive points already removed from the 
      // search area.
    invariant IsCandidate(h,m,n,z)
    invariant BoundsDiscarded(h,m,n,x,y,z)
    decreases (m-x) + y
  {
    if h(x,y-1) > 0 
    {
      CountColumn(h,m,n,x,y,z);
      UpdateCandidate(h,m,n,z,x,y-1);
      z := maximum(z,(x+1)*y);
      x := x+1;
    } 
    
    else 
    {
      DiscardRow(h,m,n,x,y,z);
      y := y-1;
    }
  }
    
    // After the loop, the remaining rectangle is empty, so every 
    // point in the original rectangle belongs to the discarded region.
    // The loop invariants show that z is either the sentinel value 0,
    // if no positive point exists, or the maximum candidate product  
    // over all points for which h(i,j) > 0.
  Finish(h,m,n,x,y,z);
}
