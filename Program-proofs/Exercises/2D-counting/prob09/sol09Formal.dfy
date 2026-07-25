/*  file: sol09Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob09
    This is exercise 9.11 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../FormalSupport.dfy"
import opened FormalSupport

//========================================================================
// Represents the points strictly inside the half-open quarter disk that 
// remain in the rectangle (x,w] × [0,y). In the initial domain, the
// horizontal boundary j = 0 is included, whereas the vertical boundary
// i = 0 is excluded. The initial call MatchingSet(0,w,w) represents all
// points in the full rectangle (0,w] × [0,w) that lie strictly inside
// the quarter disk of radius w.
ghost function MatchingSet(x:nat, y:nat, w:nat): set<(nat,nat)>
{
  set i:nat, j:nat | x < i <= w && 0 <= j < y && i*i + j*j < w*w
    :: (i,j)
}

//========================================================================
// If the rectangle has zero width or zero height, then the set of points
// strictly inside the quarter disk is empty.
lemma EmptySet(x:nat, y:nat, w:nat)
  requires x >= w || y == 0
  ensures  MatchingSet(x,y,w) == {}
{
  Set2DEquality(MatchingSet(x,y,w), {});
}

//========================================================================
// If the topmost point (x+1,y-1) of the leftmost column lies strictly
// inside the quarter disk, every point in that column lies inside the
// disk, and the number of points in that column equals the height of
// the current rectangle, which is y.
lemma CountColumn(x:nat, y:nat, w:nat)
  requires x < w && y > 0
  requires (x+1)*(x+1) + (y-1)*(y-1) < w*w
  ensures  |MatchingSet(x,y,w)| == |MatchingSet(x+1,y,w)| + y
{
  var column := ColumnSegment(x+1,0,y);

    // Since j <= y-1, we have j^2 <= (y-1)^2. Hence every
    // point (x+1,j) in the leftmost column lies inside the disk.
  forall j:nat | j < y
    ensures (x+1)*(x+1) + j*j < w*w
  {
      // The square function is monotone on the non-negative integers,
      // i.e., if a <= b then a^2 <= b^2. Hence j^2 <= (y-1)^2.
    SquareMonotone(j,y-1);
  }

    // The current matching set is the union of the matching points
    // remaining after the column is removed and the complete column.
  Set2DEquality(MatchingSet(x,y,w), MatchingSet(x+1,y,w) + column);

    // The two parts are disjoint because the column has first
    // coordinate x+1, whereas the remaining set has i > x+1.
  Set2DEquality(MatchingSet(x+1,y,w) * column, {});

    // The column contains the y points with row indices 0,...,y-1.
  ColumnSegmentCardinality(x+1,0,y);

    // As a result, the cardinality of the current matching set equals 
    // the sum of the cardinalities of the two disjoint parts.
  DisjointUnionCardinality(MatchingSet(x+1,y,w), column);
}

//========================================================================
// If the leftmost point (x+1,y-1) of the topmost row lies outside the
// quarter disk, every point in that row lies outside the disk, and the
// entire row can be discarded from the total count.
lemma DiscardRow(x:nat, y:nat, w:nat)
  requires x < w && y > 0
  requires (x+1)*(x+1) + (y-1)*(y-1) >= w*w
  ensures  MatchingSet(x,y,w) == MatchingSet(x,y-1,w)
{
    // Since x+1 <= i, we have (x+1)^2 <= i^2. Hence every
    // point in the topmost row lies outside the disk.
  forall i:nat | x < i <= w
    ensures (x+1)*(x+1) + (y-1)*(y-1)
            <= i*i + (y-1)*(y-1)
  {
      // The square function is monotone on the non-negative integers,
      // i.e., if a <= b then a^2 <= b^2. Hence (x+1)^2 <= i^2.
    SquareMonotone(x+1,i);
  }

    // Since the removed row contains no matching point, decreasing
    // y leaves the set of remaining matching points unchanged.
  Set2DEquality(MatchingSet(x,y,w), MatchingSet(x,y-1,w));
}

//========================================================================
// Counts the matching points by repeatedly removing either the leftmost 
// column or the topmost row of the remaining rectangle, while updating
// the total count.
method problem09(w:nat)
returns (z:nat)
ensures z == |MatchingSet(0,w,w)|
{
  var x:nat, y:nat := 0,w;
  z := 0;

  while x < w && y > 0
    invariant x <= w && y <= w
      // The program variable z stores the number of matching points
      // that have already been counted, while MatchingSet(x,y,w) 
      // counts the points that remain in the current rectangle. The 
      // sum of these two counts equals the total number of points in
      // the original rectangle that lie strictly inside the quarter
      // disk.
    invariant z + |MatchingSet(x,y,w)| == |MatchingSet(0,w,w)|
    decreases w - x + y
  {
    if (x+1)*(x+1) + (y-1)*(y-1) < w*w 
    {
      CountColumn(x,y,w);
      z := z + y;
      x := x + 1;
    } 
    
    else 
    {
      DiscardRow(x,y,w);
      y := y - 1;
    }
  }

    // After the loop, either x >= w or y == 0. The remaining rectangle
    // therefore has zero width or zero height, so MatchingSet is empty.
    // The cardinality invariant then implies that z is the complete 
    // count.
  EmptySet(x,y,w);
}
