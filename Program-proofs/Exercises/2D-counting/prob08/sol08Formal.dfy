/*  file: sol08Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob08
    This is exercise 9.9 from the PC reader
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
// Represents the remaining column indices i < x for which there exists
// a row index y ≤ j < n such that h(i,j) = 0. For the initial call
// MatchingSet(h,m,0,n), this set contains the indices of all columns  
// in the full rectangle that contain at least one matching point with 
// h-value 0.
ghost function MatchingSet(h:(int,int) -> int, x:nat, y:nat, 
                           n:nat): set<nat>
{
  set i:nat | i < x && exists j:nat :: y <= j < n && h(i,j) == 0 :: i
}

//========================================================================
// If the rectangle has zero width or zero height, then the set of 
// remaining column indices is empty.
lemma EmptySet(h:(int,int) -> int, x:nat, y:nat, n:nat)
  requires x == 0 || y >= n
  ensures  MatchingSet(h,x,y,n) == {}
{
  SetEquality(MatchingSet(h,x,y,n),{});
}

//========================================================================
// If h(x-1,y) ≥ 0, ascending order in the second argument implies that
// every later entry h(x-1,j), with y ≤ j < n, is at least h(x-1,y). 
// Hence the rightmost remaining column contains a zero exactly when 
// h(x-1,y) itself is zero. The column can then be removed, adding one to 
// the overall count iff indeed h(x-1,y) = 0. 
lemma DiscardColumn(h:(int,int) -> int, x:nat, y:nat, n:nat)
  requires Ordered2DInt(h, Asc, Asc)
  requires x > 0 && y < n
  requires h(x-1,y) >= 0
  ensures |MatchingSet(h,x,y,n)| ==
          |MatchingSet(h,x-1,y,n)| + ord(h(x-1,y) == 0)
{
  SetEquality(MatchingSet(h,x,y,n) - {x-1}, MatchingSet(h,x-1,y,n));
}

//========================================================================
// If h(x-1,y) < 0, ascending order in the first argument implies that
// h(i,y) ≤ h(x-1,y) < 0 for every remaining column index i < x.
// Hence the bottommost row contains no zero within the remaining
// rectangle. Removing that row therefore leaves MatchingSet unchanged.
lemma AdvanceRow(h:(int,int) -> int, x:nat, y:nat, n:nat)
  requires Ordered2DInt(h, Asc, Asc)
  requires x > 0 && y < n
  requires h(x-1,y) < 0
  ensures  MatchingSet(h,x,y,n) == MatchingSet(h,x,y+1,n)
{
  SetEquality(MatchingSet(h,x,y,n), MatchingSet(h,x,y+1,n));
}

//========================================================================
// Counts the columns containing at least one zero by repeatedly removing
// either the rightmost column or the bottommost row.
method problem08(h:(int,int) -> int, m:nat, n:nat)
returns  (z:int)
requires Ordered2DInt(h, Asc, Asc)
ensures  z == |MatchingSet(h,m,0,n)|
{
  var x:nat, y:nat := m, 0;
  z := 0;

  while x > 0 && y < n
      // The program variable z stores the number of qualifying columns
      // already removed and counted, while MatchingSet(h,x,y,n)
      // contains the qualifying column indices that remain in the
      // current rectangle. The sum of z and its cardinality equals the
      // total number of columns in the original rectangle that contain
      // at least one point with h-value 0.
    invariant z + |MatchingSet(h,x,y,n)| == |MatchingSet(h,m,0,n)|
    decreases x + (n - y)
  {
    if h(x-1,y) >= 0 
    {
      DiscardColumn(h,x,y,n);
      z := z + ord(h(x-1,y) == 0);
      x := x - 1;
    } 
    
    else 
    {
      AdvanceRow(h,x,y,n);
      y := y + 1;
    }
  }

    // After the loop, either x = 0 or y ≥ n. The remaining rectangle
    // therefore has zero width or zero height, so MatchingSet is empty.
    // The cardinality invariant then implies that z is the complete
    // number of columns containing at least one zero.
  EmptySet(h,x,y,n);
}
