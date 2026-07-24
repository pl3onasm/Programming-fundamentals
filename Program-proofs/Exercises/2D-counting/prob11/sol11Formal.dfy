/*  file: sol11Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob11
    This is exercise 9.13 from the PC reader on coincidence counting
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
// Represents all matching index pairs (i,j) in the remaining rectangle
// [x,a.Length) × [y,b.Length). The first coordinate i indexes array a, 
// the second coordinate j indexes array b.
ghost function MatchingSet(a:array<int>, b:array<int>, x:nat, 
                           y:nat): set<(nat,nat)>
  reads a, b
{
  set i:nat, j:nat |
       x <= i < a.Length && y <= j < b.Length &&
       a[i] == b[j]
    :: (i,j)
}

//========================================================================
// If either array has been exhausted, the remaining rectangle is empty.
lemma EmptySet(a:array<int>, b:array<int>, x:nat, y:nat)
  requires x >= a.Length || y >= b.Length
  ensures MatchingSet(a,b,x,y) == {}
{
  Set2DEquality(MatchingSet(a,b,x,y), {});
}

//========================================================================
// Since b is strictly increasing, b[y] ≤ b[j] for every remaining index
// j ≥ y, with strict inequality when j > y. Hence, if a[x] < b[y], then 
// we have a[x] < b[y] ≤ b[j] for every remaining index j ≥ y. Therefore,
// the leftmost column i = x contains no matching pair, and removing that 
// column leaves the set of remaining matching pairs unchanged.
lemma DiscardColumn(a:array<int>, b:array<int>, x:nat, y:nat)
  requires OrderedArray(b,Incr)
  requires x < a.Length && y < b.Length
  requires a[x] < b[y]
  ensures MatchingSet(a,b,x,y) == MatchingSet(a,b,x+1,y)
{
  Set2DEquality(MatchingSet(a,b,x,y), MatchingSet(a,b,x+1,y));
}

//========================================================================
// Since a is strictly increasing, a[x] < a[i] for every remaining index
// i > x. If a[x] ≥ b[y], then a[i] > b[y] for every i > x. Therefore, 
// (x,y) is the only possible matching pair in the bottom row j = y. 
// Removing that row decreases the remaining count by 1 exactly when 
// a[x] = b[y].
lemma AdvanceRow(a:array<int>, b:array<int>, x:nat, y:nat)
  requires OrderedArray(a,Incr) 
  requires x < a.Length && y < b.Length
  requires a[x] >= b[y]
  ensures    |MatchingSet(a,b,x,y)| 
          == |MatchingSet(a,b,x,y+1)| + ord(a[x] == b[y])
{
    // After removing the only possible matching point (x,y), the
    // remaining set consists exactly of the matching pairs in the
    // rectangle whose lower row boundary is y+1.
  Set2DEquality(MatchingSet(a,b,x,y) - {(x,y)}, MatchingSet(a,b,x,y+1));
}

//========================================================================
// Counts all matching pairs by repeatedly advancing one of the two
// indices through the strictly increasing arrays.
method problem11(a:array<int>, b:array<int>)
returns (z:int)
requires OrderedArray(a,Incr) && OrderedArray(b,Incr)
ensures z == |MatchingSet(a,b,0,0)|
{
  var x:nat, y:nat := 0,0;
  z := 0;

  while x < a.Length && y < b.Length
    invariant x <= a.Length && y <= b.Length
      // The variable z stores the number of matching pairs already
      // removed and counted. MatchingSet(a,b,x,y) contains all matching
      // pairs that remain in the current rectangle. Together, these
      // quantities equal the total number of matching pairs in the
      // original rectangle [0,a.Length) × [0,b.Length).
    invariant z + |MatchingSet(a,b,x,y)| 
              ==  |MatchingSet(a,b,0,0)|
    decreases (a.Length - x) + (b.Length - y)
  {
    if a[x] < b[y] 
    {
      DiscardColumn(a,b,x,y);
      x := x+1;
    } 
    
    else 
    {
      AdvanceRow(a,b,x,y);
      z := z + ord(a[x] == b[y]);
      y := y+1;
    }
  }

    // After the loop, at least one array has been exhausted. The
    // remaining rectangle is therefore empty, and the cardinality
    // invariant implies that z is the complete number of matches.
  EmptySet(a,b,x,y);
}
