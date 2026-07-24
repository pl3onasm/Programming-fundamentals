/*  file: sol12Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob12
    This is exercise 9.14 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps

//========================================================================
// States that z is the minimum absolute value in the rectangle
// [0,m) × [0,n). IsCandidate establishes that z is attained by an entry 
// in that rectangle. With x = m and y = 0, the remaining rectangle
// [m,m) × [0,0) is empty, so BoundsDiscarded establishes that z bounds
// from below every absolute value in the original rectangle.
ghost predicate Minimum(h:(int,int) -> int, m:nat, n:nat, z:int)
{
  IsCandidate(h,m,n,z) && BoundsDiscarded(h,m,n,m,0,z)
}

//========================================================================
// States that z is the absolute value of an entry in the rectangle 
// [0,m) × [0,n) and is therefore a candidate for the minimum absolute 
// value.
ghost predicate IsCandidate(h:(int,int) -> int, m:nat, n:nat, z:int)
{
  exists i:nat, j:nat :: i < m && j < n && z == abs(h(i,j))
}

//========================================================================
// States that z is a lower bound on the absolute values of all entries
// that have already been removed from the search area and lie outside
// the remaining rectangle [x,m) × [0,y)
ghost predicate BoundsDiscarded(h:(int,int) -> int, m:nat, n:nat,
                                x:nat, y:nat, z:int)
{
  forall i:nat, j:nat ::
    i < m && j < n && (i < x || y <= j) ==> z <= abs(h(i,j))
}

//========================================================================
// If the h-value of the north-west corner (x,y-1) is negative, then its
// absolute value is the smallest in the entire leftmost column. This is
// true because h is ascending in its second argument. That is, for all
// 0 ≤ j < y, we have h(x,j) ≤ h(x,y-1) < 0. The north-west corner is 
// therefore the largest, and hence closest to zero, of all negative 
// entries in that column. Updating z with its absolute value extends 
// BoundsDiscarded to the newly removed column.
lemma DiscardColumn(h:(int,int) -> int, m:nat, n:nat, x:nat, y:nat, z:int)
  requires Ordered2DInt(h, Asc, Asc)
  requires x < m && 0 < y <= n
  requires h(x,y-1) < 0
  requires BoundsDiscarded(h,m,n,x,y,z)
  ensures BoundsDiscarded(h,m,n,x+1,y,minimum(z,abs(h(x,y-1))))
{
}

//========================================================================
// If the h-value of the north-west corner (x,y-1) is non-negative, it has 
// the smallest absolute value in the entire top row. This is true because
// h is ascending in its first argument, so that for all x ≤ i < m, we 
// have 0 ≤ h(x,y-1) ≤ h(i,y-1). The north-west corner is therefore 
// closest to zero in that row. Updating z with its absolute value extends
// BoundsDiscarded to the newly removed row. 
lemma DiscardRow(h:(int,int) -> int, m:nat, n:nat, x:nat, y:nat, z:int)
  requires Ordered2DInt(h, Asc, Asc)
  requires x < m && 0 < y <= n
  requires h(x,y-1) >= 0
  requires BoundsDiscarded(h,m,n,x,y,z)
  ensures BoundsDiscarded(h,m,n,x,y-1,minimum(z,abs(h(x,y-1))))
{
}

//========================================================================
// Once the remaining rectangle is empty, every point in the original 
// rectangle now belongs to the discarded region. BoundsDiscarded shows 
// that z bounds every absolute value in the original rectangle from 
// below, while IsCandidate shows that z is attained by some entry in that
// rectangle. Together, these properties establish Minimum(h,m,n,z), the 
// postcondition of the main method, and z is therefore the minimum 
// absolute value in the rectangle [0,m) × [0,n).
lemma Finish(h:(int,int) -> int, m:nat, n:nat, x:nat, y:nat, z:int)
  requires x <= m && y <= n
  requires x == m || y == 0
  requires IsCandidate(h,m,n,z)
  requires BoundsDiscarded(h,m,n,x,y,z)
  ensures Minimum(h,m,n,z)
{
}

//========================================================================
// Finds the minimum absolute value by repeatedly removing either the
// leftmost column or the topmost row of the remaining rectangle.
method problem12(h:(int,int) -> int, m:nat, n:nat)
returns (z:int)
requires Ordered2DInt(h, Asc, Asc)
requires m > 0 && n > 0
ensures Minimum(h,m,n,z)
{
  var x:nat, y:nat := 0,n;
    // z is initialized to the absolute h-value of an entry that is
    // guaranteed to be part of the search area, since m > 0 and n > 0
  z := abs(h(0,0));

  while x < m && y > 0
    invariant x <= m && y <= n
      // The program variable z is the absolute value of an actual
      // entry and bounds from below the absolute values of all entries
      // already removed from the search area.
    invariant IsCandidate(h,m,n,z)
    invariant BoundsDiscarded(h,m,n,x,y,z)
    decreases (m - x) + y
  {
    if h(x,y-1) < 0 
    {
      DiscardColumn(h,m,n,x,y,z);
      z := minimum(z,abs(h(x,y-1)));
      x := x + 1;
    } 
    
    else 
    {
      DiscardRow(h,m,n,x,y,z);
      z := minimum(z,abs(h(x,y-1)));
      y := y - 1;
    }
  }
    
  Finish(h,m,n,x,y,z);
}