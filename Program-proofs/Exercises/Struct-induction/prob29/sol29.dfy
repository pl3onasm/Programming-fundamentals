/*  file: sol29.dfy
    author: David De Potter
    description: proof by finite-set induction of the inclusion-exclusion
      principle for two sets
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Proves by induction on A the subtraction-free form of the
// inclusion-exclusion principle:
//   |A ∪ B| + |A ∩ B| = |A| + |B|
lemma {:induction false} InclusionExclusion<T>(A:set<T>, B:set<T>)
  ensures   |A + B| + |A * B| == |A| + |B|
  decreases |A|
{
  if A == {}
  {
      // Base case: Q({}) is true
    assert |A + B| + |A * B| == |A| + |B| by
    {
      calc
      {
        |A + B| + |A * B|;
          // Replace A by the empty set
        == |{} + B| + |{} * B|;
          // Union with the empty set gives B
          // Intersection with the empty set gives {}
        == |B| + 0;
          // Arithmetic
        == 0 + |B|;
          // The set A is empty, so its cardinality is 0
        == |A| + |B|;
      }
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set A. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:T :| x in A;
    var R   := A - {x};

      // Induction hypothesis
      // Assume Q(R) is true: |R ∪ B| + |R ∩ B| = |R| + |B|
    InclusionExclusion(R, B);

    if x in B
    {
        // Since x already belongs to B, inserting it into R does not
        // enlarge the union, but it enlarges the intersection by one
      SetEquality(A + B, R + B);
      SetEquality(A * B, (R * B) + {x});

      calc
      {
        |A + B| + |A * B|;
          // Rewrite the union and intersection
          // according to the above set equalities
        == |R + B| + |(R * B) + {x}|;
          // Inserting x enlarges the intersection R ∩ B by one
        == |R + B| + (|R * B| + 1);
          // Regroup the terms
        == (|R + B| + |R * B|) + 1;
          // Apply the induction hypothesis
        == (|R| + |B|) + 1;
          // Regroup the terms
        == (|R| + 1) + |B|;
          // Since R = A - {x} and x ∈ A, we have |R| + 1 = |A|
        == |A| + |B|;
      }
    }

    else
    {
        // Since x does not belong to B, inserting it into R enlarges
        // the union by one, but leaves the intersection unchanged
      SetEquality(A + B, (R + B) + {x});
      SetEquality(A * B, R * B);

      calc
      {
        |A + B| + |A * B|;
          // Rewrite the union and intersection
          // according to the above set equalities
        == |(R + B) + {x}| + |R * B|;
          // Inserting x enlarges the union R ∪ B by one
        == (|R + B| + 1) + |R * B|;
          // Regroup the terms
        == (|R + B| + |R * B|) + 1;
          // Apply the induction hypothesis
        == (|R| + |B|) + 1;
          // Regroup the terms
        == (|R| + 1) + |B|;
          // Since R = A - {x} and x ∈ A, we have |R| + 1 = |A|
        == |A| + |B|;
      }
    }
  }
}

//========================================================================
// Derives the standard form of the inclusion-exclusion principle:
//   |A ∪ B| = |A| + |B| - |A ∩ B|
lemma InclusionExclusionStandard<T>(A:set<T>, B:set<T>)
  ensures |A + B| == |A| + |B| - |A * B|
{
    // Obtain the subtraction-free equality
  InclusionExclusion(A, B);

    // Rearrange the equality to obtain the standard form
  calc
  {
    |A + B|;
      // Add and subtract |A ∩ B| 
    == (|A + B| + |A * B|) - |A * B|;
      // Apply InclusionExclusion 
    == (|A| + |B|) - |A * B|;
  }
}
