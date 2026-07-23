/*  file: sol13Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    fully formal solution to prob13
    This is exercise 9.15 from the PC reader
    NOTE: This solution is machine verified end to end, as described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

include "../../FormalSupport.dfy"
include "../../commonSupport.dfy"
import opened FormalSupport
import opened CommonFunctions

//========================================================================
// Expresses the property that f is a positive function, 
// i.e. f(k) > 0 for all k in the domain of f
ghost predicate Positive(f:nat -> nat)
{
  forall k :: f(k) > 0
}

//========================================================================
// Computes the sum of the values of f over the half-open interval [i,j)
ghost function IntervalSum(f:nat -> nat, i:nat, j:nat): nat
  decreases j-i
{
  if i >= j then 0 else f(i) + IntervalSum(f,i+1,j)
}

//========================================================================
// Extends the right endpoint of the interval [x,y) by 1, and updates the 
// interval sum accordingly by adding f(y) to the previous sum. The lemma 
// is proved by induction on the length of the interval [x,y), which
// is y-x. The recursive call supplies the induction hypothesis.
lemma ExtendRight(f:nat -> nat, x:nat, y:nat)
  requires x <= y
  ensures IntervalSum(f,x,y+1) == IntervalSum(f,x,y) + f(y)
  decreases y - x
{
  if x < y 
  {
      // The recursive call yields the induction hypothesis stating that
      // the lemma holds for the smaller interval [x+1,y):
      // IntervalSum(f,x+1,y+1) == IntervalSum(f,x+1,y) + f(y)
    ExtendRight(f,x+1,y);
  }

    // Base case: if x == y, then [x,y) is empty and has sum 0,
    // while [x,y+1) contains only f(y). Hence,
    // IntervalSum(f,x,y+1) == 0 + f(y).
}

//========================================================================
// Extending the right endpoint of the interval [x,y) to any j > y gives
// a strictly larger interval sum, since f is positive. The lemma is 
// proved by induction on the length of the extension j-y. 
lemma StrictlyExtendRight(f:nat -> nat, x:nat, y:nat, j:nat)
  requires Positive(f)
  requires x <= y < j
  ensures IntervalSum(f,x,y) < IntervalSum(f,x,j)
  decreases j - y
{
  if j > y+1
  {
      // Apply the induction hypothesis to the shorter extension
      // from y to j-1
    StrictlyExtendRight(f,x,y,j-1);

      // Extending the endpoint once more from j-1 to j adds the
      // positive value f(j-1)
    ExtendRight(f,x,j-1);
  }
  else
  {
      // Since y < j and j <= y+1, we have j == y+1. Extending the
      // interval by this one position adds the positive value f(y).
    ExtendRight(f,x,y);
  }
}

//========================================================================
// Moving the left endpoint of the interval [x,y) to the right can only
// decrease the interval sum, because every value of f is a non-negative
// natural number.
lemma DropLeft(f:nat -> nat, x:nat, i:nat, y:nat)
  requires x <= i <= y
  ensures IntervalSum(f,i,y) <= IntervalSum(f,x,y)
  decreases i - x
{
  if x < i 
  {
    assert IntervalSum(f,x+1,y) <= IntervalSum(f,x,y);
    DropLeft(f,x+1,i,y);
  }
}

//========================================================================
// Represents all matching half-open intervals [i,j) in the remaining
// search region. The parameters x and y are lower bounds:
//
//   x <= i   means that intervals starting before x have been processed
//   y <= j   means that intervals ending before y have been processed
//
// MatchingSet(f,x,y,a,n) therefore does not represent only the current
// window [x,y). It represents every remaining matching interval [i,j) 
// with i >= x and j >= y. The program variable s separately stores the 
// sum of the single current window [x,y). Thus, x and y have two related 
// roles:
//
//   [x,y)                    is the current window tracked by s
//   MatchingSet(f,x,y,a,n)   contains all matching intervals in the
//                            remaining search region
//
// The same values x and y are therefore used both as the exact endpoints
// of the current window and as the lower bounds of the remaining region.
// The current window [x,y) is the corner interval of that region. And the
// initial call MatchingSet(f,0,0,a,n) represents the full search region
// from the problem statement.
ghost function MatchingSet(f:nat -> nat, x:nat, y:nat, a:nat, 
                           n:nat): set<(nat,nat)>
{
  set i:nat, j:nat | x <= i <= j < n && y <= j && IntervalSum(f,i,j) == a
    :: (i,j)
}

//========================================================================
// If either search coordinate has reached n, the remaining search region 
// is empty, so the count is 0.
lemma EmptySet(f:nat -> nat, x:nat, y:nat, a:nat, n:nat)
  requires x >= n || y >= n
  ensures MatchingSet(f,x,y,a,n) == {}
{
  Set2DEquality(MatchingSet(f,x,y,a,n), {});
}

//========================================================================
// If the current sum is at least a, [x,y) is the only possible matching
// interval that starts at x.
// Increasing x to x+1 removes from MatchingSet every remaining interval
// whose left endpoint is x. These intervals have the form [x,j), where
// j >= y. The current interval [x,y) may match, but every interval with
// j > y has a strictly larger sum and therefore cannot match.
lemma AdvanceLeft(f:nat -> nat, x:nat, y:nat, a:nat, n:nat)
  requires Positive(f)
  requires 0 < a && x <= y < n
  requires IntervalSum(f,x,y) >= a
  ensures |MatchingSet(f,x,y,a,n)| ==
          |MatchingSet(f,x+1,y,a,n)| + ord(IntervalSum(f,x,y) == a)
{
    // Every endpoint strictly after y gives a strictly larger sum.
    // Since IntervalSum(f,x,y) >= a, all such intervals have sum
    // strictly greater than a and cannot be matching intervals.
  forall j:nat | y < j < n
    ensures IntervalSum(f,x,y) < IntervalSum(f,x,j)
  {
      // Make the precondition of StrictlyExtendRight explicit.
    assert x <= y < j;
    StrictlyExtendRight(f,x,y,j);
  }

    // The interval [x,y) is the only remaining interval starting at x
    // that can contribute to the count. It contributes exactly when
    // its sum equals a.
  if IntervalSum(f,x,y) == a
  {
    assert (x,y) in MatchingSet(f,x,y,a,n);
  }
  else
  {
    assert IntervalSum(f,x,y) > a;
    assert (x,y) !in MatchingSet(f,x,y,a,n);
  }

    // Apart from the possible interval [x,y), no remaining matching
    // interval starts at x. Removing it therefore leaves precisely
    // the search region whose left boundary is x+1.
  Set2DEquality(MatchingSet(f,x,y,a,n) - {(x,y)}, 
                MatchingSet(f,x+1,y,a,n));
}

//========================================================================
// If the current sum is below a, no remaining interval ending at y can
// match, because moving its left endpoint right can only decrease its 
// sum.
// MatchingSet(f,x,y,a,n) already contains candidate intervals with every
// right endpoint j >= y, including j = y+1, y+2, and so on. Replacing y
// by y+1 does not add those later intervals. It only removes the layer
// consisting of intervals whose right endpoint is exactly y:
//   [i,y), where x <= i <= y
// The proof below shows that this removed layer contains no matching 
// interval. Consequently, removing it leaves MatchingSet unchanged.
lemma AdvanceRight(f:nat -> nat, x:nat, y:nat, a:nat, n:nat)
  requires x <= y < n
  requires IntervalSum(f,x,y) < a
  ensures MatchingSet(f,x,y,a,n) == MatchingSet(f,x,y+1,a,n)
{
  forall i:nat | x <= i <= y
    ensures IntervalSum(f,i,y) < a
  {
    // Every remaining interval ending at y is obtained by moving the
    // left endpoint of [x,y) to some i >= x. Since f has non-negative
    // values, this can only decrease the sum:
    //   IntervalSum(f,i,y) <= IntervalSum(f,x,y) <  a
    // Hence, no interval in the discarded endpoint layer j = y matches.
    DropLeft(f,x,i,y);
  }
}

//========================================================================
// Counts all matching intervals with a standard sliding-window search.
method problem13(f:nat -> nat, a:nat, n:nat)
returns (z:nat)
requires Positive(f)
requires 0 < a && 0 < n
ensures z == |MatchingSet(f,0,0,a,n)|
{
  var x:nat, y:nat, s:nat := 0,0,0;
  z := 0;

  while x < n && y < n
    invariant x <= y <= n
      // The variable s tracks only the current window [x,y)
    invariant s == IntervalSum(f,x,y)
      // MatchingSet is broader than the current window: it contains
      // every remaining matching interval [i,j) with i >= x and j >= y.
      // The variable z stores the number of matching intervals already
      // removed from the search region. The sum of z and the cardinality
      // of MatchingSet is therefore the number of matching intervals in
      // the original search region.
    invariant z + |MatchingSet(f,x,y,a,n)| == |MatchingSet(f,0,0,a,n)|
    decreases 2*n - x - y
  {
    if s >= a 
    {
        // The current window [x,y) has reached or exceeded the target.
        // AdvanceLeft proves that among all remaining intervals starting
        // at x, only [x,y) can still match. It is counted when s == a,
        // after which every interval starting at x is removed from the
        // remaining search region by increasing x.
      AdvanceLeft(f,x,y,a,n);
      z := z + ord(s == a);
      s := s - f(x);
      x := x + 1;
    } 
    
    else 
    {
        // Here the current window [x,y) has sum below a. AdvanceRight
        // proves that no remaining interval ending exactly at y can
        // match. Increasing y therefore discards only an empty endpoint
        // layer from MatchingSet so that we have:
        //   MatchingSet(f,x,y,a,n) == MatchingSet(f,x,y+1,a,n).
        // At the same time, the current window tracked by s is extended 
        // from [x,y) to [x,y+1). These are different operations:
        //   MatchingSet loses the ruled-out layer j = y,
        //   while the current window gains the new element f(y)
      AdvanceRight(f,x,y,a,n);
      ExtendRight(f,x,y);
      s := s + f(y);
      y := y + 1;
    }
  }

    // After the loop: x ≥ n or y ≥ n. In either case, the remaining
    // search region is empty, so the count of matching intervals is 0.
    // The cardinality invariant then implies z is the complete count.
  EmptySet(f,x,y,a,n);
}
