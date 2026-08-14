/*  file: sol24.dfy
    author: David De Potter
    description: proof by finite-set induction of the cardinality of a
      partition formed by intersection and difference
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Proves that intersecting A with B and removing B from A partitions A 
// into two disjoint sets with cardinalities that sum to the cardinality 
// of A:   |A ∩ B| + |A \ B| = |A|
lemma {:induction false} SetPartitionCardinality<T>(A:set<T>, B:set<T>)
  ensures   |A * B| + |A - B| == |A|
  decreases |A|
{
  if A == {}
  {
    assert |A * B| + |A - B| == |A| by
    {
      calc
      {
        |A * B| + |A - B|;
          // Replace A by the empty set
        == |{} * B| + |{} - B|;
          // The intersection of the empty set with any set is empty
        == 0 + |{} - B|;
          // The difference of the empty set with any set is empty
        == 0 + 0;
          // Arithmetic
        == 0;
          // The set A is empty, so its cardinality is 0
        == |A|;
      }
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set A. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:T :| x in A;
    var R := A - {x};

      // Induction hypothesis
      // Assume Q(R) is true:
      //   |R ∩ B| + |R \ B| = |R|
    SetPartitionCardinality(R, B);

    if x in B
    {
        // Since x ∈ B, inserting x into R enlarges the intersection
        // by one and leaves the difference unchanged.
      SetEquality(A * B, (R * B) + {x});
      SetEquality(A - B, R - B);
      InsertCardinality(R * B, x);

      calc
      {
        |A * B| + |A - B|;
          // Rewrite the two parts using the set equalities above
        == |(R * B) + {x}| + |R - B|;
          // Inserting x enlarges the intersection by one
        == (|R * B| + 1) + |R - B|;
          // Regroup the terms to apply the induction hypothesis
        == (|R * B| + |R - B|) + 1;
          // Apply the induction hypothesis
        == |R| + 1;
          // The singleton {x} enlarges R by one since x ∉ R
        == |R + {x}|;
          // Inserting x into R reconstructs A
        == |A|;
      }
    }

    else
    {
        // Since x ∉ B, inserting x into R leaves the intersection
        // unchanged and enlarges the difference by one.
      SetEquality(A * B, R * B);
      SetEquality(A - B, (R - B) + {x});
      InsertCardinality(R - B, x);

      calc
      {
        |A * B| + |A - B|;
          // Rewrite the two parts using the set equalities above
        == |R * B| + |(R - B) + {x}|;
          // Inserting x enlarges the difference by one
        == |R * B| + (|R - B| + 1);
          // Regroup the terms to apply the induction hypothesis
        == (|R * B| + |R - B|) + 1;
          // Apply the induction hypothesis
        == |R| + 1;
          // The singleton {x} enlarges R by one since x ∉ R
        == |R + {x}|;
          // Inserting x into R reconstructs A
        == |A|;
      }
    }
  }
}

//========================================================================
// Derives the cardinality of the difference when B is a subset of A:
//   |A \ B| = |A| - |B|
lemma DifferenceCardinality<T>(A:set<T>, B:set<T>)
  requires B <= A
  ensures  |A - B| == |A| - |B|
{
    // Since B ⊆ A, intersecting A with B gives B itself.
  SetEquality(A * B, B);

    // Partition A into the elements inside and outside B.
  SetPartitionCardinality(A, B);

  calc
  {
    |A - B|;
      // Introduce |B| and subtract it again
    == (|B| + |A - B|) - |B|;
      // Since B ⊆ A, the intersection A ∩ B equals B
    == (|A * B| + |A - B|) - |B|;
      // Apply the lemma proved above: |A ∩ B| + |A \ B| = |A|
    == |A| - |B|;
  }
}
