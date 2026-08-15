/*  file: sol26.dfy
    author: David De Potter
    description: proof by finite-set induction of the cardinality of a
      Cartesian product of two finite sets
*/

include "../prob25/sol25.dfy"
import opened SetSupport

//========================================================================
// Defines the Cartesian product of the finite sets S and T:
//   Cartesian(S, T) = {(x, y) | x ∈ S ∧ y ∈ T}
// The Cartesian product of two finite sets is the set of all ordered 
// pairs whose first component is an element of S and whose second
// component is an element of T.
ghost function Cartesian<A, B>(S:set<A>, T:set<B>): set<(A, B)>
{
  set x:A, y:B | x in S && y in T :: (x, y)
}

//========================================================================
// Defines the row of pairs obtained by fixing the first component x:
//   Row(x, T) = {(x, y) | y ∈ T}
ghost function Row<A, B>(x:A, T:set<B>): set<(A, B)>
{
    // Image is defined in prob25/sol25.dfy
    // Here the function y ↦ (x, y) is applied to every element of T,
    // producing a set of pairs whose first component is x and whose
    // second component is an element of T
  Image((y:B) => (x, y), T)
}

//========================================================================
// Proves that a row contains exactly one pair for every element of T:
//   |Row(x, T)| = |T|
lemma RowCardinality<A, B>(x:A, T:set<B>)
  ensures |Row(x, T)| == |T|
{
    // The function y ↦ (x, y) is injective because equality of two
    // resulting pairs implies equality of their second components.
  assert forall y, z ::
    y in T && z in T && (x, y) == (x, z) ==> y == z;

    // Apply the lemma proved in problem25 to the function y ↦ (x, y)
  InjectImageCardinality((y:B) => (x, y), T);
}

//========================================================================
// Proves by induction on S that the cardinality of its Cartesian product
// with T is the product of their cardinalities:
//   |Cartesian(S, T)| = |S| * |T|
lemma {:induction false} CartesianCardinality<A, B>(S:set<A>, T:set<B>)
  ensures   |Cartesian(S, T)| == |S| * |T|
  decreases |S|
{
  if S == {}
  {
      // Base case: Q({}) is true
    calc
    {
      |Cartesian(S, T)|;
        // The Cartesian product with an empty first set is empty
      == 0;
        // Arithmetic
      == 0 * |T|;
        // The set S is empty, so its cardinality is 0
      == |S| * |T|;
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set S. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:A :| x in S;
    var R := S - {x};

      // Induction hypothesis
      // Assume Q(R) is true:
      //   |Cartesian(R, T)| = |R| * |T|
    CartesianCardinality(R, T);

      // The Cartesian product over S consists of the product over R
      // together with the new row whose first component is x
    SetEquality(Cartesian(S, T), Cartesian(R, T) + Row(x, T));

      // Since x ∉ R, the new row is disjoint from the Cartesian
      // product over R
    DisjointUnionCardinality(Cartesian(R, T), Row(x, T));

      // Split the Cartesian product into the product over R and
      // the new row
    RowCardinality(x, T);

    calc
    {
      |Cartesian(S, T)|;
        // Split the product into the old product and the new row
      == |Cartesian(R, T) + Row(x, T)|;
        // The two parts are disjoint, so the cardinality of 
        // their union is the sum of their cardinalities
      == |Cartesian(R, T)| + |Row(x, T)|;
        // Apply the induction hypothesis and RowCardinality
      == |R| * |T| + |T|;
        // Factor out |T|
      == (|R| + 1) * |T|;
        // Since R = S - {x} and x ∈ S, we have |R| + 1 = |S|
      == |S| * |T|;
    }
  }
}
