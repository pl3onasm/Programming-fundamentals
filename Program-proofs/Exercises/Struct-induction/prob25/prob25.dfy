/*  file: prob25.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob25
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Defines the image of a finite set s under a function f:
//   Image(f, s) = {f(x) | x ∈ s}
// Different elements of s may have the same image under f, but sets do
// not retain duplicate values. Therefore, the image of a finite set  
// may have fewer elements than the original set.
ghost function Image<A, B>(f:A -> B, s:set<A>): set<B>
{
  set x | x in s :: f(x)
}

//========================================================================
// Proves that taking the image of a finite set cannot increase its
// cardinality:  |Image(f, s)| ≤ |s|
lemma {:induction false} ImageCardinalityBound<A, B>(f:A -> B, s:set<A>)
  ensures   |Image(f, s)| <= |s|
  decreases |s|
{
  /*
    Prove this lemma by induction on the finite set s.

      Base case, Q({}):
        Show that       |Image(f, {})| ≤ |{}|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ s and let R = s - {x}

        Assume that     |Image(f, R)| ≤ |R|
        and prove that  |Image(f, R ∪ {x})| ≤ |R ∪ {x}|

    The value f(x) may already belong to Image(f, R). Therefore,
    inserting x into s adds at most one new value to its image.
  */
}

//========================================================================
// Proves that the image of a finite set has the same cardinality as the
// original set when f is injective on s, i.e. when different elements
// of s have different images under f. The precondition expresses this
// using the equivalent contrapositive formulation: if two elements of s
// have the same image, then they must be equal. This formulation is more
// convenient for the finite-set induction proof.
lemma {:induction false} InjectImageCardinality<A, B>(f:A -> B, s:set<A>)
  requires forall x, y :: x in s && y in s && f(x) == f(y) ==> x == y
  ensures   |Image(f, s)| == |s|
  decreases |s|
{
  /*
    Prove this lemma by induction on the finite set s.

      Base case, Q({}):
        Show that       |Image(f, {})| = |{}|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ s and let R = s - {x}

        Assume that     |Image(f, R)| = |R|
        and prove that  |Image(f, R ∪ {x})| = |R ∪ {x}|

    Since f is injective on s, the new value f(x) cannot already belong
    to Image(f, R). It therefore enlarges the image by exactly one.
  */
}
