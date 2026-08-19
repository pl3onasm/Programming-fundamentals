/*  file: prob27.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob27
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Defines the image of a finite set s under a function f:
//   Image(f, S) = {f(x) | x ∈ S}
// Different elements of S may have the same image under f, but sets do
// do not retain duplicate values. Therefore, the image of a finite set  
// may have fewer elements than the original set S.
ghost function Image<A, B>(f:A -> B, S:set<A>): set<B>
{
  set x | x in S :: f(x)
}

//========================================================================
// Proves that taking the image of a finite set cannot increase its
// cardinality:  |Image(f, S)| ≤ |S|
lemma {:induction false} ImageCardinalityBound<A, B>(f:A -> B, S:set<A>)
  ensures   |Image(f, S)| <= |S|
  decreases |S|
{
  /*
    Prove this lemma by induction on the finite set S.

      Base case, Q({}):
        Show that       |Image(f, {})| ≤ |{}|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ S and let R = S - {x}

        Assume that     |Image(f, R)| ≤ |R|
        and prove that  |Image(f, R ∪ {x})| ≤ |R ∪ {x}|

    The value f(x) may already belong to Image(f, R). Therefore,
    inserting x into S adds at most one new value to its image.
  */
}

//========================================================================
// Proves that the image of a finite set has the same cardinality as the
// original set when f is injective on S, i.e. when different elements
// of S have different images under f. The precondition expresses this
// using the equivalent contrapositive formulation: if two elements of S
// have the same image, then they must be equal. This formulation is more
// convenient for the finite-set induction proof.
lemma {:induction false} InjectImageCardinality<A, B>(f:A -> B, S:set<A>)
  requires forall x, y :: x in S && y in S && f(x) == f(y) ==> x == y
  ensures   |Image(f, S)| == |S|
  decreases |S|
{
  /*
    Prove this lemma by induction on the finite set S.

      Base case, Q({}):
        Show that       |Image(f, {})| = |{}|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ S and let R = S - {x}

        Assume that     |Image(f, R)| = |R|
        and prove that  |Image(f, R ∪ {x})| = |R ∪ {x}|

    Since f is injective on S, the new value f(x) cannot already belong
    to Image(f, R). It therefore enlarges the image by exactly one.
  */
}
