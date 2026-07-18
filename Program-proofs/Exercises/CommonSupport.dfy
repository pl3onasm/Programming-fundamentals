/* file: CommonSupport.dfy
   author: David De Potter
   description: common definitions for PC-style and formal proofs
*/

module CommonFunctions 
{
  //========================================================================
  // Returns the smaller of the two integer values x and y.
  function minimum(x:int, y:int): int
  {
    if x <= y then x else y
  }

  //========================================================================
  // Returns the larger of the two integer values x and y.
  function maximum(x:int, y:int): int
  {
    if x >= y then x else y
  }

  //========================================================================
  // Returns the absolute value of x: x itself when x is non-negative,
  // and its additive inverse -x when x is negative.
  function abs(x:int): int
  {
    if x >= 0 then x else -x
  }

  //========================================================================
  // Converts a Boolean value into a natural number. It returns 1 when b
  // is true and 0 when b is false. This is useful for expressing whether
  // a condition contributes one item to a count.
  function ord(b:bool): nat
  {
    if b then 1 else 0
  }
}


module MonotonicityProps
{
  //========================================================================
  // Describes four possible ordering properties using four constructors:
  //   Asc  : ascending, or non-decreasing
  //           x <= y implies f(x) <= f(y)
  //   Incr : strictly increasing
  //           x < y implies f(x) < f(y)
  //   Desc : descending, or non-increasing
  //           x <= y implies f(x) >= f(y)
  //   Decr : strictly decreasing
  //           x < y implies f(x) > f(y)
  datatype Order = | Asc
                   | Incr
                   | Desc
                   | Decr

  //========================================================================
  // Determines how two natural-number indices i and j must be related for 
  // the selected ordering property.
  // This function determines only the strictness of the index comparison.
  // The direction of the corresponding value comparison is determined
  // separately by ValueOrder.
  function IndexOrderNat(o:Order, i:nat, j:nat): bool
  {
    match o
    case Asc  => i <= j
    case Incr => i <  j
    case Desc => i <= j
    case Decr => i <  j
  }

  //========================================================================
  // Determines how two integer indices i and j must be related for the 
  // selected ordering property.
  // This function determines only the strictness of the index comparison.
  // The direction of the corresponding value comparison is determined
  // separately by ValueOrder.
  function IndexOrderInt(o:Order, i:int, j:int): bool
  {
    match o
    case Asc  => i <= j
    case Incr => i <  j
    case Desc => i <= j
    case Decr => i <  j
  }

  //========================================================================
  // Determines how two integer values x and y must be related for the 
  // selected ordering property:
  //   Asc  requires x <= y
  //   Incr requires x <  y
  //   Desc requires x >= y
  //   Decr requires x >  y
  // Together, IndexOrderNat or IndexOrderInt and ValueOrder express the
  // complete direction and strictness of an ordering property.
  function ValueOrder(o:Order, x:int, y:int): bool
  {
    match o
    case Asc  => x <= y
    case Incr => x <  y
    case Desc => x >= y
    case Decr => x >  y
  }

  //========================================================================
  // Expresses that a function f over pairs of natural numbers has the
  // specified ordering in each of its two arguments.
  // The first quantified condition keeps the second argument k fixed and
  // compares f(i,k) with f(j,k). It therefore describes the ordering in
  // the first argument. The second quantified condition keeps the first 
  // argument i fixed and compares f(i,j) with f(i,k). It therefore 
  // describes the ordering in the second argument.
  // For example, Ordered2DNat(f,Incr,Desc) means that f is strictly
  // increasing in its first argument and non-increasing in its second.
  ghost predicate Ordered2DNat(
    f:(nat,nat) -> int, first:Order, second:Order
  )
  {
    (forall i,j,k ::
      IndexOrderNat(first,i,j) ==>
        ValueOrder(first,f(i,k),f(j,k))) &&

    (forall i,j,k ::
      IndexOrderNat(second,j,k) ==>
        ValueOrder(second,f(i,j),f(i,k)))
  }

  //========================================================================
  // Expresses that a function f over pairs of integers has the specified
  // ordering in each of its two arguments.
  // The first quantified condition keeps the second argument k fixed and
  // compares f(i,k) with f(j,k). The second condition keeps the first
  // argument i fixed and compares f(i,j) with f(i,k).
  // This predicate is the integer-indexed counterpart of Ordered2DNat.
  // For example, Ordered2DInt(f,Asc,Decr) means that f is non-decreasing
  // in its first argument and strictly decreasing in its second.
  ghost predicate Ordered2DInt(
    f:(int,int) -> int, first:Order, second:Order
  )
  {
    (forall i,j,k ::
      IndexOrderInt(first,i,j) ==>
        ValueOrder(first,f(i,k),f(j,k))) &&

    (forall i,j,k ::
      IndexOrderInt(second,j,k) ==>
        ValueOrder(second,f(i,j),f(i,k)))
  }

  //========================================================================
  // Expresses that the elements in the half-open array segment [lo,hi)
  // have the selected ordering.
  // For every pair of indices i and j in this segment that satisfies the 
  // appropriate index comparison, the corresponding values arr[i] and 
  // arr[j] must satisfy the value comparison described by order.
  // For example, OrderedArraySegment(arr,lo,hi,Incr) states that
  // arr[i] < arr[j] whenever lo <= i < j < hi.
  ghost predicate OrderedArraySegment(
    arr:array<int>, lo:int, hi:int, order:Order
  )
    requires 0 <= lo <= hi <= arr.Length
    reads arr
  {
    forall i,j ::
      lo <= i && IndexOrderInt(order,i,j) && j < hi
      ==>
      ValueOrder(order,arr[i],arr[j])
  }

  //========================================================================
  // Expresses that the complete array has the selected ordering. It is a
  // convenient abbreviation for applying OrderedArraySegment to the
  // half-open interval [0,arr.Length)
  ghost predicate OrderedArray(arr:array<int>, order:Order)
    reads arr
  {
    OrderedArraySegment(arr,0,arr.Length,order)
  }
}
