/* file: FormalSupport.dfy
   author: David De Potter
   description: reusable definitions and lemmas for fully formal 
   Dafny proofs
*/

module FormalSupport 
{
  //========================================================================
  // Proves that two sets are equal iff they contain exactly the same
  // elements. This is the set-extensionality principle:
  //
  //   s == t  if and only if
  //   every element belongs to s exactly when it belongs to t.
  //
  // The element type T is generic, so the lemma applies to sets of any 
  // type.
  lemma SetEquality<T>(s:set<T>, t:set<T>)
    requires forall q :: q in s <==> q in t
    ensures s == t
  {
      // Dafny knows the extensionality principle for sets, so the
      // membership equivalence in the precondition is sufficient.
  }

  //========================================================================
  // A coordinate-based version of SetEquality for sets of grid points.
  // Its precondition uses two separate coordinates i and j, while
  // SetEquality expects one arbitrary pair.
  lemma Set2DEquality(s:set<(nat,nat)>, t:set<(nat,nat)>)
    requires forall i:nat, j:nat ::
      (i,j) in s <==> (i,j) in t
    ensures s == t
  {
    forall pair:(nat,nat)
      ensures pair in s <==> pair in t
    {
        // Every pair consists of its first and second components
      assert pair == (pair.0,pair.1);

        // Instantiate the precondition with those two components
      assert (pair.0,pair.1) in s <==> (pair.0,pair.1) in t;
    }

    SetEquality(s,t);
  }

  //========================================================================
  // Proves that multiplication by the same natural number preserves an
  // inequality: if a <= b, then a*c <= b*c.
  // NOTE: The lemma is proved by induction on c. The recursive call
  // explicitly supplies the induction hypothesis for c-1. Dafny verifies
  // through the decreases clause that the recursive argument becomes
  // strictly smaller.
  lemma MulMonotone(a:nat, b:nat, c:nat)
    requires a <= b
    ensures a*c <= b*c
    decreases c
  {
    if c > 0 
    {
        // Apply the induction hypothesis to multiplication by c-1
      MulMonotone(a,b,c-1);

        // Add a to the left-hand side and b to the right-hand side
      calc 
      {
        a*c;
        == a*(c-1) + a;
        <= b*(c-1) + b;
        == b*c;
      }
    }
  }

  //========================================================================
  // Proves that squaring preserves the order of natural numbers: if
  // a <= b, then a^2 <= b^2.
  lemma SquareMonotone(a:nat, b:nat)
    requires a <= b
    ensures a*a <= b*b
  {
      // First replace the left factor a by b
    MulMonotone(a,b,a);

      // Then replace the right factor a by b
    MulMonotone(a,b,b);

    calc 
    {
      a*a;
      <= b*a;
      == a*b;
      <= b*b;
    }
  }

  //========================================================================
  // Proves that inserting a new element into a finite set increases its
  // cardinality by exactly one.
  lemma InsertCardinality<T>(s:set<T>, q:T)
    requires q !in s
    ensures |s + {q}| == |s| + 1
  {
    // Dafny proves this using its built-in finite-set cardinality rules
  }

  //========================================================================
  // Represents the finite horizontal segment of grid points given by
  // {(i,row) | lo <= i < hi} 
  ghost function RowSegment(lo:nat, hi:nat, row:nat): set<(nat,nat)>
    requires lo <= hi
  {
    set i:nat | lo <= i < hi :: (i,row)
  }

  //========================================================================
  // Proves that the horizontal segment [lo,hi) contains exactly hi-lo
  // grid points.
  // NOTE: The lemma is proved by induction on the segment length hi-lo.
  // The recursive call counts the shorter segment [lo,hi-1), after which
  // the final point (hi-1,row) is inserted.
  lemma RowSegmentCardinality(lo:nat, hi:nat, row:nat)
    requires lo <= hi
    ensures |RowSegment(lo,hi,row)| == hi - lo
    decreases hi - lo
  {
    if lo < hi 
    {
        // Count the shorter segment ending at hi-1
      RowSegmentCardinality(lo,hi-1,row);

        // Set equality shows that adding the final point (hi-1,row) to the
        // shorter segment gives the full segment [lo,hi). (Since this is a
        // half-open segment, the final point is (hi-1,row), not (hi,row).)
      Set2DEquality(RowSegment(lo,hi,row),
                    RowSegment(lo,hi-1,row) + {(hi-1,row)});

        // Adding the final point increases the cardinality by 1
      InsertCardinality(RowSegment(lo,hi-1,row), (hi-1,row));
    } 
    
    else 
    {
        // Base case: If lo == hi, the half-open segment is empty, and
        // we can start counting from 0.
      Set2DEquality(RowSegment(lo,hi,row), {});
    }
  }

  //========================================================================
  // Proves that the cardinality of the union of two disjoint finite sets
  // equals the sum of their separate cardinalities.
  lemma DisjointUnionCardinality<T>(s:set<T>, t:set<T>)
    requires s * t  == {}
    ensures |s + t| == |s| + |t|
  {
    // In Dafny, + denotes set union and * denotes set intersection.
    // Since the sets are disjoint, their cardinalities can be added.
  }

  //========================================================================
  // Represents the finite vertical segment of grid points given by
  // {(col,j) | lo <= j < hi}
  ghost function ColumnSegment(col:nat, lo:nat, hi:nat): set<(nat,nat)>
    requires lo <= hi
  {
    set j:nat | lo <= j < hi :: (col,j)
  }

  //========================================================================
  // Proves that the vertical segment [lo,hi) contains exactly hi-lo
  // grid points.
  // NOTE: The lemma is proved by induction on the segment length hi-lo.
  // The recursive call counts the shorter segment [lo,hi-1), after which
  // the final point (col,hi-1) is inserted.
  lemma ColumnSegmentCardinality(col:nat, lo:nat, hi:nat)
    requires lo <= hi
    ensures |ColumnSegment(col,lo,hi)| == hi - lo
    decreases hi - lo
  {
    if lo < hi 
    {
        // Count the shorter segment ending at hi-1
      ColumnSegmentCardinality(col,lo,hi-1);

        // Set equality shows that adding the final point (col,hi-1) to the
        // shorter segment gives the full segment [lo,hi). (Since this is a
        // half-open segment, the final point is (col,hi-1), not (col,hi).)
      Set2DEquality(ColumnSegment(col,lo,hi),
                    ColumnSegment(col,lo,hi-1) + {(col,hi-1)});

        // Adding the final point increases the cardinality by 1
      InsertCardinality(ColumnSegment(col,lo,hi-1), (col,hi-1));
    } 
    
    else 
    {
        // Base case: If lo == hi, the half-open segment is empty, and
        // we can start counting from 0.
      Set2DEquality(ColumnSegment(col,lo,hi), {});
    }
  }
}


module ArrayAggregates  
{
  //========================================================================
  // Defines the sum of the array elements in the half-open range [lo,hi).
  // The empty range has sum 0
  ghost function ArraySum(a:array<nat>, lo:nat, hi:nat): int
    requires lo <= hi <= a.Length
    reads a
    decreases hi - lo
  {
    if lo == hi then
      0
    else
      ArraySum(a,lo,hi-1) + a[hi-1]
  }

  //========================================================================
  // Proves that extending a summation range by one position adds the new
  // final element a[hi]
  lemma ArraySumAddLast(a:array<nat>, lo:nat, hi:nat)
    requires lo <= hi < a.Length
    ensures    ArraySum(a,lo,hi+1) 
            == ArraySum(a,lo,hi) + a[hi]
  {
    // Follows by unfolding ArraySum once at the upper bound hi+1
  }

  //========================================================================
  // Proves that an array sum over [lo,hi) can be split at any intermediate
  // index mid into the sums over [lo,mid) and [mid,hi)
  // NOTE: The lemma is proved by induction on hi-mid. The recursive call
  // explicitly supplies the induction hypothesis for the shorter range
  // [lo,hi-1). Dafny then unfolds the relevant ArraySum definitions and
  // completes the remaining arithmetic reasoning automatically.
  lemma ArraySumSplit(a:array<nat>, lo:nat, mid:nat, hi:nat)
    requires lo <= mid <= hi <= a.Length
    ensures    ArraySum(a,lo,hi) 
            == ArraySum(a,lo,mid) + ArraySum(a,mid,hi)
    decreases hi - mid
  {
    if mid < hi 
    {
        // Apply the induction hypothesis to the shorter range [lo,hi-1)
      ArraySumSplit(a,lo,mid,hi-1);

        // Unfold the sums ending at hi. Both the complete range
        // [lo,hi) and the right subrange [mid,hi) extend their
        // corresponding ranges ending at hi-1 by the same element a[hi-1]
    }

      // If mid == hi, the right subrange [mid,hi) is empty, and the
      // required equality follows directly from ArraySum(a,mid,hi) == 0
  }

  //========================================================================
  // Defines the prefix sum of the first k array elements as the array sum
  // over the half-open range [0,k)
  ghost function PrefixSum(a:array<nat>, k:nat): int
    requires k <= a.Length
    reads a
  {
    ArraySum(a,0,k)
  }

  //========================================================================
  // Proves that extending a prefix by one position adds the new final
  // element a[k]
  lemma PrefixSumStep(a:array<nat>, k:nat)
    requires k < a.Length
    ensures    PrefixSum(a,k+1) 
            == PrefixSum(a,k) + a[k]
  {
      // Apply the corresponding range-extension lemma with lo = 0
    ArraySumAddLast(a,0,k);
  }

  //========================================================================
  // Defines the product of the array elements in the half-open range
  // [lo,hi). The empty range has product 1.
  ghost function ArrayProduct(a:array<nat>, lo:nat, hi:nat): int
    requires lo <= hi <= a.Length
    reads a
    decreases hi - lo
  {
    if lo == hi then
      1
    else
      ArrayProduct(a,lo,hi-1) * a[hi-1]
  }

  //========================================================================
  // Proves that extending a product range by one position multiplies the
  // previous product by the new final element a[hi]
  lemma ArrayProductAddLast(a:array<nat>, lo:nat, hi:nat)
    requires lo <= hi < a.Length
    ensures    ArrayProduct(a,lo,hi+1) 
            == ArrayProduct(a,lo,hi) * a[hi]
  {
    // Follows by unfolding ArrayProduct once at the upper bound hi+1
  }

  //========================================================================
  // Proves that an array product over [lo,hi) can be split at any
  // intermediate index mid into the products over [lo,mid) and [mid,hi)
  // NOTE: The lemma is proved by induction on hi-mid. The recursive call
  // explicitly supplies the induction hypothesis for the shorter range
  // [lo,hi-1). Dafny then unfolds the relevant ArrayProduct definitions 
  // and completes the remaining arithmetic reasoning automatically.
  lemma ArrayProductSplit(a:array<nat>, lo:nat, mid:nat, hi:nat)
    requires lo <= mid <= hi <= a.Length
    ensures    ArrayProduct(a,lo,hi)
            == ArrayProduct(a,lo,mid)
             * ArrayProduct(a,mid,hi)
    decreases hi - mid
  {
    if mid < hi 
    {
        // Apply the induction hypothesis to the shorter range [lo,hi-1)
      ArrayProductSplit(a,lo,mid,hi-1);

        // Unfold the products ending at hi. Both the complete range
        // [lo,hi) and the right subrange [mid,hi) extend their
        // corresponding ranges ending at hi-1 by the same element a[hi-1]
    }

      // If mid == hi, the right subrange [mid,hi) is empty, and the
      // required equality follows directly from ArrayProduct(a,mid,hi) == 1
  }
}
