/*  file: Monotonicity.dfy
    author: David De Potter
    description: reusable predicates for expressing ordering properties
      of arrays and two-dimensional functions
*/

module MonotonicityProps
{
  //======================================================================
  // Selects how values at indices i < j must be ordered:
  //   Asc  : non-decreasing,      f(i) ≤ f(j)
  //   Incr : strictly increasing, f(i) <  f(j)
  //   Desc : non-increasing,      f(i) ≥ f(j)
  //   Decr : strictly decreasing, f(i) >  f(j)
  datatype Order = Asc
                 | Incr
                 | Desc
                 | Decr

  //======================================================================
  // Compares two integer values using the selected ordering.
  function ValueOrder(o:Order, x:int, y:int): bool
  {
    match o
    case Asc  => x <= y
    case Incr => x <  y
    case Desc => x >= y
    case Decr => x >  y
  }

  //======================================================================
  // Expresses that a function f over pairs of natural numbers has the
  // specified ordering in each of its two arguments.
  // The first quantified condition keeps the second argument k fixed and
  // compares f(i,k) with f(j,k). It therefore describes the ordering in
  // the first argument. The second quantified condition keeps the first 
  // argument i fixed and compares f(i,j) with f(i,k). It therefore 
  // describes the ordering in the second argument.
  // For example, Ordered2DNat(f,Incr,Desc) means that f is strictly
  // increasing in its first argument and non-increasing in its second.
  ghost predicate Ordered2DNat(f:(nat, nat) -> int, first:Order, 
                               second:Order)
  {
    (forall i:nat, j:nat, k:nat ::
      i < j ==> ValueOrder(first, f(i, k), f(j, k))) &&

    (forall i:nat, j:nat, k:nat ::
      j < k ==> ValueOrder(second, f(i, j), f(i, k)))
  }

  //======================================================================
  // Expresses that a function f over pairs of integers has the specified
  // ordering in each of its two arguments.
  // The first quantified condition keeps the second argument k fixed and
  // compares f(i,k) with f(j,k). The second condition keeps the first
  // argument i fixed and compares f(i,j) with f(i,k).
  // For example, Ordered2DInt(f,Asc,Decr) means that f is non-decreasing
  // in its first argument and strictly decreasing in its second.
  ghost predicate Ordered2DInt(f:(int, int) -> int, first:Order, 
                               second:Order)
  {
    (forall i:int, j:int, k:int ::
      i < j ==> ValueOrder(first, f(i, k), f(j, k))) &&

    (forall i:int, j:int, k:int ::
      j < k ==> ValueOrder(second, f(i, j), f(i, k)))
  }

  //======================================================================
  // Expresses that the half-open array segment [lo, hi) has the selected
  // ordering. For example, OrderedArraySegment(arr, lo, hi, Incr)
  // requires arr[i] < arr[j] whenever lo ≤ i < j < hi.
  ghost predicate OrderedArraySegment(arr:array<int>, lo:int, hi:int, 
                                      order:Order)
    requires 0 <= lo <= hi <= arr.Length
    reads arr
  {
    forall i, j ::
      lo <= i < j < hi ==> ValueOrder(order, arr[i], arr[j])
  }

  //======================================================================
  // Expresses that the complete array has the selected ordering.
  ghost predicate OrderedArray(arr:array<int>, order:Order)
    reads arr
  {
    OrderedArraySegment(arr, 0, arr.Length, order)
  }
}