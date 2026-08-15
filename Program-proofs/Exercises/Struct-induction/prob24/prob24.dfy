/*  file: prob24.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob24

    NOTE:
    Although Dafny can prove the lemmas in this file automatically, the 
    purpose of this exercise is to practice writing an explicit 
    finite-set induction proof. Its proof should therefore distinguish
    the base case and inductive case, and explicitly invoke the induction 
    hypothesis by applying the lemma recursively to the strictly smaller 
    set R = A - {x}, obtained by removing an arbitrary element x from A. 
    The second lemma should then be derived as a direct corollary of 
    the first.
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Proves that intersecting A with B and removing B from A partitions A 
// into two disjoint sets with cardinalities that sum to the cardinality 
// of A:   |A ∩ B| + |A \ B| = |A|
// In Dafny, * denotes set intersection and - denotes set difference.
lemma {:induction false} SetPartitionCardinality<T>(A:set<T>, B:set<T>)
  ensures   |A * B| + |A - B| == |A|
  decreases |A|
{
  /*
    Prove this lemma by induction on the finite set A.

      Base case, Q({}):
        Show that       |{} ∩ B| + |{} \ B| = |{}|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ A and let R = A - {x}

        Assume that     |R ∩ B| + |R \ B| = |R|

        and prove that  |A ∩ B| + |A \ B| = |A|

    Distinguish whether x ∈ B. If it is, inserting x enlarges the
    intersection by one. Otherwise, it enlarges the difference by one.
  */
}

//========================================================================
// Derives the cardinality of the difference when B is a subset of A:
//   |A \ B| = |A| - |B|
lemma DifferenceCardinality<T>(A:set<T>, B:set<T>)
  requires B <= A
  ensures  |A - B| == |A| - |B|
{
  /*
    Since B ⊆ A, the intersection A ∩ B equals B. Apply
    SetPartitionCardinality to obtain the desired equality.
  */
}
