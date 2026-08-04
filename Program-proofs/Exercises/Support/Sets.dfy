/* file: Sets.dfy
   author: David De Potter
   description: reusable set-extensionality, cardinality, and finite
   grid-segment lemmas 
*/

module SetSupport 
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



