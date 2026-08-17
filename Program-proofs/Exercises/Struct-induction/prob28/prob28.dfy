/*  file: prob28.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob28
*/

include "../prob25/sol25.dfy"
import opened SetSupport

//========================================================================
// Recursively defines 2^n.
function Pow2(n:nat): nat
  decreases n
{
  if n == 0 then 1 else 2 * Pow2(n-1)
}

//========================================================================
// Defines the power set of S, i.e. the set containing all subsets of S:
//   PowerSet(S) = {Z | Z ⊆ S}
ghost function PowerSet<T>(S:set<T>): set<set<T>>
{
  set Z:set<T> | Z <= S :: Z
}

//========================================================================
// Adds x to every set in the finite family Sets:
//   AddToEach(x, Sets) = {Z ∪ {x} | Z ∈ Sets}
ghost function AddToEach<T>(x:T, Sets:set<set<T>>): set<set<T>>
{
    // Image is defined in prob25/sol25.dfy
    // The expression (Z:set<T>) => Z + {x} is a lambda expression 
    // defining the anonymous function Z ↦ Z ∪ {x}. Applying this 
    // function to every element of Sets produces the set 
    // {Z ∪ {x} | Z ∈ Sets}.
  Image((Z:set<T>) => Z + {x}, Sets)
}

//========================================================================
// Splits the power set of R ∪ {x} into the subsets that exclude x
// and those that include x. The first family is PowerSet(R), while
// the second is obtained by adding x to every subset of R.
lemma PowerSetStep<T>(R:set<T>, x:T)
  requires x !in R
  ensures PowerSet(R + {x}) == PowerSet(R) + AddToEach(x, PowerSet(R))
  ensures PowerSet(R) * AddToEach(x, PowerSet(R)) == {}
{
  /*
    Prove the first set equality by extensionality: for an arbitrary
    set Z, show that Z belongs to PowerSet(R + {x}) exactly when it
    belongs to the union of the two families, that is, to at least
    one of them.

    Then prove that the two families are disjoint by showing that no
    set Z can belong to both of them.

    Every subset of R ∪ {x} either excludes x and belongs to
    PowerSet(R), or includes x and can be obtained by adding x to a
    subset of R. The two resulting families are disjoint because
    x ∉ R: every set in PowerSet(R) excludes x, whereas every set in
    AddToEach(x, PowerSet(R)) includes x. Consequently, the intersection 
    is the empty family {}, not the singleton family {{}}, which would 
    contain the empty set as a common member of both families.
  */
}

//========================================================================
// Proves that adding x to every subset of R preserves the number of
// sets in the family.
lemma AddedSubsetsCardinality<T>(R:set<T>, x:T)
  requires x !in R
  ensures |AddToEach(x, PowerSet(R))| == |PowerSet(R)|
{
  /*
    Apply InjectImageCardinality from problem25 to the function
    Z ↦ Z ∪ {x}, which can be expressed using the lambda expression 
    (Z:set<T>) => Z + {x}.

    This function is injective on PowerSet(R), because x belongs to
    none of the original subsets. Therefore, if V ∪ {x} = Z ∪ {x},
    removing x from both sides gives V = Z.
  */
}

//========================================================================
// Proves that a finite set with n elements has 2^n different subsets:
//   |PowerSet(S)| = 2^|S|
lemma {:induction false} PowerSetCardinality<T>(S:set<T>)
  ensures |PowerSet(S)| == Pow2(|S|)
  decreases |S|
{
  /*
    Prove this lemma by induction on the finite set S.

      Base case, Q({}):
        Show that         |PowerSet({})| = 2^0
        The power set of the empty set is the singleton family {{}},
        whose only element is the empty set. Therefore, its cardinality
        is 1 = 2^0.

      Inductive case, Q(R) ⇒ Q(R ∪ {x}):
        Choose an arbitrary element x ∈ S and let R = S - {x}

        Assume that       |PowerSet(R)| = 2^|R|
        and prove that    |PowerSet(S)| = 2^|S|

    Use PowerSetStep to split PowerSet(S) into two disjoint families.
    AddedSubsetsCardinality shows that both families have the same
    cardinality, so inserting x doubles the number of subsets.
  */
}
