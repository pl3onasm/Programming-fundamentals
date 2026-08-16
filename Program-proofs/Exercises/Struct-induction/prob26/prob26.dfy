/*  file: prob26.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob26
*/

include "../prob25/sol25.dfy"
import opened SetSupport

//========================================================================
// Defines the Cartesian product of the finite sets S and T:
//   Cartesian(S, T) = {(x, y) | x ∈ S ∧ y ∈ T}
// The Cartesian product of two finite sets S and T is the set of all  
// ordered pairs whose first component is an element of S and whose 
// second component is an element of T.
ghost function Cartesian<A, B>(S:set<A>, T:set<B>): set<(A, B)>
{
  set x:A, y:B | x in S && y in T :: (x, y)
}

//========================================================================
// Defines the row of pairs obtained by fixing the first component x and
// allowing the second component to range over the finite set T:
//   Row(x, T) = {(x, y) | y ∈ T}
ghost function Row<A, B>(x:A, T:set<B>): set<(A, B)>
{
    // Image is defined in prob25/sol25.dfy
    // The expression (y:B) => (x, y) is a lambda expression defining
    // the anonymous function y ↦ (x, y). Applying this function to
    // every element of T produces a set of pairs whose first component
    // is x and whose second component is an element of T.
  Image((y:B) => (x, y), T)
}

//========================================================================
// Proves that a row contains exactly one pair for every element of T:
//   |Row(x, T)| = |T|
lemma RowCardinality<A, B>(x:A, T:set<B>)
  ensures |Row(x, T)| == |T|
{
  /*
    Apply InjectImageCardinality from problem25 to the function
      y ↦ (x, y).

    This function is injective because equality of the resulting pairs
    implies equality of their second components.
  */
}

//========================================================================
// Proves that the cardinality of a Cartesian product is the product of
// the separate cardinalities:  |Cartesian(S, T)| = |S| * |T|
lemma {:induction false} CartesianCardinality<A, B>(S:set<A>, T:set<B>)
  ensures   |Cartesian(S, T)| == |S| * |T|
  decreases |S|
{
  /*
    Prove this lemma by induction on the finite set S.

      Base case, Q({}):
        Show that         |Cartesian({}, T)| = |{}| * |T|

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ S and let R = S - {x}

        Assume that       |Cartesian(R, T)| = |R| * |T|

        and prove that    |Cartesian(R ∪ {x}, T)| = |R ∪ {x}| * |T|

    The pairs whose first component is x form Row(x, T). This row is
    disjoint from Cartesian(R, T) and has cardinality |T|.
  */
}
