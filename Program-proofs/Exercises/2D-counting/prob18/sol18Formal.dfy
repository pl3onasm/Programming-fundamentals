/*  file: sol18Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob18
    This is exercise 9.20 from the PC reader
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
// Represents the remaining row indices j, with y ≤ j < x, for which
// there exists an index i satisfying j ≤ i < x and f(i,j) = c. For the
// initial call MatchingSet(f,d+1,0,c), this set contains exactly the
// row indices j with 0 ≤ j ≤ d that contain a matching point in the
// triangular domain j ≤ i ≤ d.
ghost function MatchingSet(f:(nat,nat) -> int, x:nat, y:nat,
                           c:int): set<nat>
{
  set j:nat | y <= j < x && exists i:nat :: j <= i < x && f(i,j) == c :: j
}

//========================================================================
// If the triangular search region is empty, then the set of remaining
// matching row indices is empty.
lemma EmptySet(f:(nat,nat) -> int, x:nat, y:nat, c:int)
  requires y >= x
  ensures  MatchingSet(f,x,y,c) == {}
{
  SetEquality(MatchingSet(f,x,y,c), {});
}

//========================================================================
// If f(x-1,y) > c, ascending order in f's second argument implies that
// every later entry f(x-1,j), with y ≤ j < x, is greater than c.
// Hence the rightmost column contains no matching points. Removing that
// column therefore leaves MatchingSet unchanged.
lemma DiscardColumn(f:(nat,nat) -> int, x:nat, y:nat, c:int)
  requires Ordered2DNat(f, Asc, Asc)
  requires y < x
  requires f(x-1,y) > c
  ensures  MatchingSet(f,x,y,c) == MatchingSet(f,x-1,y,c)
{
    // Since the removed rightmost column contains no matching point,
    // decrementing the upper column boundary from x to x - 1 does not
    // change the set of remaining row indices that still contain a
    // matching point.
  SetEquality(MatchingSet(f,x,y,c), MatchingSet(f,x-1,y,c));
}

//========================================================================
// If f(x-1,y) ≤ c, ascending order in f's first argument implies that
// every entry in the bottommost row is at most f(x-1,y). Hence that row
// contains a matching point exactly when f(x-1,y) itself equals c. The 
// row can then be removed, adding one to the overall count iff indeed
// f(x-1,y) = c.
lemma AdvanceRow(f:(nat,nat) -> int, x:nat, y:nat, c:int)
  requires Ordered2DNat(f, Asc, Asc)
  requires y < x
  requires f(x-1,y) <= c
  ensures |MatchingSet(f,x,y,c)| 
       == |MatchingSet(f,x,y+1,c)| + ord(f(x-1,y) == c)
{
    // After accounting for whether row y contains a match, removing the
    // row index y from the current set of qualifying rows is equivalent 
    // to incrementing the lower bound of the remaining search region
  SetEquality(MatchingSet(f,x,y,c) - {y}, MatchingSet(f,x,y+1,c));
}

//========================================================================
// Counts the row indices containing at least one matching point by
// repeatedly removing either the rightmost column or the bottommost 
// row of the remaining triangular search region.
method problem18(f:(nat,nat) -> int, c:int, d:nat)
returns  (z:int)
requires Ordered2DNat(f, Asc, Asc)
ensures  z == |MatchingSet(f,d+1,0,c)|
{
  var x:nat, y:nat := d+1, 0;
  z := 0;

  while y < x
      // The program variable z stores the number of qualifying rows
      // already removed and counted, while MatchingSet(f,x,y,c)
      // contains the qualifying row indices that remain in the current
      // triangular search region. The sum of z and its cardinality
      // equals the total number of rows in the original triangular
      // domain that contain at least one point with f-value c.
    invariant y <= x
    invariant z + |MatchingSet(f,x,y,c)| == |MatchingSet(f,d+1,0,c)|
    decreases x - y
  {
    if f(x-1,y) > c
    {
      DiscardColumn(f,x,y,c);
      x := x - 1;
    }

    else
    {
      AdvanceRow(f,x,y,c);
      z := z + ord(f(x-1,y) == c);
      y := y + 1;
    }
  }

    // After the loop, y ≥ x. The remaining triangular search region
    // is therefore empty, so MatchingSet is empty. The cardinality
    // invariant then implies that z is the complete number of rows
    // containing at least one matching point.
  EmptySet(f,x,y,c);
}
