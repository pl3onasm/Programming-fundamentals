/*  file: sol20Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob20
    This is exercise 9.22 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../FormalSupport.dfy"
import opened FormalSupport

//========================================================================
// Expresses that p is convex in its first argument: if p holds at both
// (x,w) and (z,w), it also holds at every point (y,w) with x ≤ y ≤ z
ghost predicate ConvexFirst(p:(int,int) -> bool)
{
  forall x,y,z,w:int :: p(x,w) && x <= y <= z && p(z,w) ==> p(y,w)
}

//========================================================================
// Expresses that p is monotone in its second argument: if p holds at 
// (x,y), it also holds at (x,z) for every z ≥ y
ghost predicate MonoSecond(p:(int,int) -> bool)
{
  forall x,y,z:int :: p(x,y) && y <= z ==> p(x,z)
}

//========================================================================
// Represents the points satisfying p in the remaining rectangle
// [x,v) × [0,y)
ghost function MatchingSet(p:(int,int) -> bool, x:nat, 
                           y:nat, v:nat): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i < v && j < y && p(i,j) :: (i,j)
}
 
//========================================================================
// If the rectangle has zero width or zero height, no points remain, and
// the matching set is empty.
lemma EmptySet(p:(int,int) -> bool, x:nat, y:nat, v:nat)
  requires x == v || y == 0
  ensures MatchingSet(p,x,y,v) == {}
{
  Set2DEquality(MatchingSet(p,x,y,v), {});
}

//========================================================================
// If p is false at the top of the leftmost column, monotonicity in p's
// second argument implies that the entire column contains no match.
lemma DiscardLeftColumn(p:(int,int) -> bool, x:nat, y:nat, v:nat)
  requires MonoSecond(p)
  requires x < v && y > 0
  requires !p(x,y-1)
  ensures MatchingSet(p,x,y,v) == MatchingSet(p,x+1,y,v)
{
  Set2DEquality(MatchingSet(p,x,y,v), MatchingSet(p,x+1,y,v));
}

//========================================================================
// If p is false at the top of the rightmost column, monotonicity in p's
// second argument implies that the entire column contains no match.
lemma DiscardRightColumn(p:(int,int) -> bool, x:nat, y:nat, v:nat)
  requires MonoSecond(p)
  requires x < v && y > 0
  requires !p(v-1,y-1)
  ensures MatchingSet(p,x,y,v) == MatchingSet(p,x,y,v-1)
{
  Set2DEquality(MatchingSet(p,x,y,v), MatchingSet(p,x,y,v-1));
}

//========================================================================
// If p holds at both endpoints of the top row, convexity in p's first
// argument implies that every point in that row satisfies p.
lemma CountTopRow(p:(int,int) -> bool, x:nat, y:nat, v:nat)
  requires ConvexFirst(p)
  requires x < v && y > 0
  requires p(x,y-1) && p(v-1,y-1)
  ensures |MatchingSet(p,x,y,v)| == |MatchingSet(p,x,y-1,v)| + (v-x)
{
  var topRow := RowSegment(x,v,y-1);
    
    // We split the matching set into the top row and the smaller 
    // rectangle below it
  Set2DEquality(MatchingSet(p,x,y,v), MatchingSet(p,x,y-1,v) + topRow);

    // The smaller rectangle contains only rows j < y-1, whereas
    // every point in topRow has second coordinate y-1; hence the
    // two sets are disjoint
  Set2DEquality(MatchingSet(p,x,y-1,v) * topRow, {});

    // The removed half-open row segment [x,v) has v-x points
  RowSegmentCardinality(x,v,y-1);

    // Since both parts are disjoint, their cardinalities add up to the
    // cardinality of the original matching set
  DisjointUnionCardinality(MatchingSet(p,x,y-1,v), topRow);
}

//========================================================================
// Counts the matching points by repeatedly removing the top row or one
// of the two outer columns of the remaining rectangle.
method problem20(p:(int,int) -> bool, m:nat, n:nat)
returns (z:int)
requires ConvexFirst(p)
requires MonoSecond(p)
ensures z == |MatchingSet(p,0,n,m)|
{
  var x:nat, y:nat, v:nat := 0,n,m;
  z := 0;

  while x < v && y > 0
    invariant x <= v <= m
    invariant y <= n
      // z stores the number of matching points already counted, while
      // MatchingSet contains those that remain in the current rectangle
      // [x,v) × [0,y) Their sum is the total number of matching points 
      // in the original rectangle [0,m) × [0,n)
    invariant z + |MatchingSet(p,x,y,v)| == |MatchingSet(p,0,n,m)|
    decreases (v-x) + y
  {
    if p(x,y-1) && p(v-1,y-1) 
    {
      CountTopRow(p,x,y,v);
      z := z + (v-x);
      y := y-1;
    } 
    
    else if !p(x,y-1) 
    {
      DiscardLeftColumn(p,x,y,v);
      x := x+1;
    } 
    
    else 
    {   
        // The left endpoint satisfies p, but the two endpoints do not
        // both satisfy p. Therefore, the right endpoint is false.
      DiscardRightColumn(p,x,y,v);
      v := v-1;
    }
  }
    
    // When the loop terminates, either the rectangle has zero width or 
    // zero height, so the remaining matching set is empty. The loop 
    // invariant then implies that the count is complete in z.
  EmptySet(p,x,y,v);
}
