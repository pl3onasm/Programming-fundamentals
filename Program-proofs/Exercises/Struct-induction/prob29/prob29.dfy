/*  file: prob29.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob29

    NOTE:
    Although Dafny can prove both lemmas in this file automatically, the
    purpose of the first lemma is to practice writing an explicit
    finite-set induction proof. Its proof should therefore distinguish
    the base and inductive cases and explicitly invoke the induction
    hypothesis by applying the lemma recursively to the strictly smaller
    set R = A - {x}, obtained by removing an arbitrary element x from A.
    The second lemma should then be derived as a direct corollary of the
    first.
    We prove the subtraction-free form first because set cardinalities are
    natural numbers, and subtraction on natural numbers is truncated at 0.
    A direct induction proof of the standard form would therefore require
    additional work to justify the subtraction steps. In the subtraction-
    free form, each inductive case simply increases both sides by one.
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Proves the inclusion-exclusion principle for two finite sets in its
// subtraction-free form:
//   |A ∪ B| + |A ∩ B| = |A| + |B|
// In Dafny, + denotes union and * denotes intersection.
lemma {:induction false} InclusionExclusion<T>(A:set<T>, B:set<T>)
  ensures   |A + B| + |A * B| == |A| + |B|
  decreases |A|
{
  /*
    Prove this lemma by induction on the finite set A.

      Base case, Q({}):
        Show that       |{} ∪ B| + |{} ∩ B| = |{}| + |B|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ A and let R = A - {x}

        Assume that     |R ∪ B| + |R ∩ B| = |R| + |B|

        and prove that  |A ∪ B| + |A ∩ B| = |A| + |B|.

    Distinguish whether x ∈ B. If it is, the intersection grows by
    one while the union remains unchanged. Otherwise, the union grows 
    by one while the intersection remains unchanged.
  */
}

//========================================================================
// Derives the standard form of the inclusion-exclusion principle:
//   |A ∪ B| = |A| + |B| - |A ∩ B|
lemma InclusionExclusionStandard<T>(A:set<T>, B:set<T>)
  ensures |A + B| == |A| + |B| - |A * B|
{
  /*
    Apply InclusionExclusion and rearrange the resulting equality.
  */
}
