/*  file: sol28.dfy
    author: David De Potter
    description: proof by finite-set induction that a finite set with n
      elements has 2^n subsets
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
  Image((Z:set<T>) => Z + {x}, Sets)
}

//========================================================================
// Splits the power set of R ∪ {x} into the subsets that exclude x
// and those that include x, and proves that these families are disjoint.
lemma PowerSetStep<T>(R:set<T>, x:T)
  requires x !in R
  ensures PowerSet(R + {x}) == PowerSet(R) + AddToEach(x, PowerSet(R))
  ensures PowerSet(R) * AddToEach(x, PowerSet(R)) == {}
{
    // First we prove that the two families together 
    // contain exactly all subsets of R ∪ {x}
  forall Z:set<T> ensures 
         Z in PowerSet(R + {x}) 
    <==> Z in (PowerSet(R) + AddToEach(x, PowerSet(R)))
  {
      // Proving the implication from left to right
      //    Z ∈ PowerSet(R ∪ {x}) 
      // ⇒ Z ∈ (PowerSet(R) ∪ AddToEach(x, PowerSet(R)))
    if Z in PowerSet(R + {x})
    {
      if x in Z
      {
          // Removing x from Z leaves a subset of R. Adding x 
          // back therefore places Z in the second family.
        var withoutX := Z - {x};
        assert withoutX <= R;
        assert withoutX in PowerSet(R);
        SetEquality(Z, withoutX + {x});
        assert Z in AddToEach(x, PowerSet(R));
      }

      else
      {
          // A subset that excludes x is already a subset of R.
          // Therefore, Z belongs to the first family.
        assert Z <= R;
        assert Z in PowerSet(R);
      }
    } 

      // Proving the implication from right to left
      //    Z ∈ (PowerSet(R) ∪ AddToEach(x, PowerSet(R))) 
      // ⇒ Z ∈ PowerSet(R ∪ {x})
    if Z in PowerSet(R) + AddToEach(x, PowerSet(R))
    {
      if Z in PowerSet(R)
      {
          // Every subset of R is also a subset of R ∪ {x}
        assert Z <= R + {x};
      }

      else
      {
          // Membership in the second family gives an original 
          // subset of R to which x was added.
        assert Z in AddToEach(x, PowerSet(R));
        var orig:set<T> :| orig in PowerSet(R) && Z == orig + {x};
        assert Z <= R + {x};
      }
    }
  }

    // Next we prove that the two families are disjoint. 
    // We prove this by contradiction: if a set Z belongs to both 
    // families, then it must both include and exclude x, which is false.
  forall Z:set<T> ensures 
         Z in PowerSet(R) * AddToEach(x, PowerSet(R)) 
    <==> Z in {}
  {
    if Z in PowerSet(R) * AddToEach(x, PowerSet(R))
    {
      assert Z in PowerSet(R);
      assert Z in AddToEach(x, PowerSet(R));
      assert x in Z;
      assert x !in Z;
    }
  }
}

//========================================================================
// Proves that adding x to every subset of R preserves the number of
// sets in the family.
lemma AddedSubsetsCardinality<T>(R:set<T>, x:T)
  requires x !in R
  ensures |AddToEach(x, PowerSet(R))| == |PowerSet(R)|
{
    // The function Z ↦ Z ∪ {x} is injective on PowerSet(R). Since x is
    // absent from R, it is also absent from all its subsets.
  assert forall V:set<T>, Z:set<T> ::
    (V in PowerSet(R) && Z in PowerSet(R) && V + {x} == Z + {x}) 
    ==> V == Z;

    // Apply the lemma proved in problem25 to the function Z ↦ Z ∪ {x}
    // expressed using the lambda expression (Z:set<T>) => Z + {x}
    // The lemma proves that the cardinality of the image of an injective
    // function is equal to the cardinality of its domain.
  InjectImageCardinality((Z:set<T>) => Z + {x}, PowerSet(R));
}

//========================================================================
// Proves by induction on S that a finite set with n elements has 2^n
// different subsets:  |PowerSet(S)| = 2^|S|
lemma {:induction false} PowerSetCardinality<T>(S:set<T>)
  ensures   |PowerSet(S)| == Pow2(|S|)
  decreases |S|
{
  if S == {}
  {
      // The power set of the empty set is the singleton family {{}},
      // whose only element is the empty set.
    var empty:set<T> := {};

      // Proves the precondition of SetEquality
    forall Z:set<T> ensures Z in PowerSet(S) <==> Z in {empty}
    {    
        // Implication from left to right
        // Z ∈ PowerSet(S) ⇒ Z ∈ {{}}
      if Z in PowerSet(S)
      {
        SetEquality(Z, empty);
      }

        // Implication from right to left
        // Z ∈ {{}} ⇒ Z ∈ PowerSet(S)
      if Z in {empty}
      {
        assert Z == empty;
        assert Z <= S;
      }
    }

      // Proves the postcondition of SetEquality: PowerSet(S) = {{}}
    SetEquality(PowerSet(S), {empty});
      
      // Base case: Q({}) is true.
    calc
    {
      |PowerSet(S)|;
        // The power set contains only the empty set, 
        // so its cardinality is 1
      == 1;
        // Fold Pow2(0)
      == Pow2(0);
        // The set S is empty, so its cardinality is 0
      == Pow2(|S|);
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set S. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:T :| x in S;
    var R   := S - {x};

    SetEquality(S, R + {x});

      // Induction hypothesis
      // Assume Q(R) is true:  |PowerSet(R)| = 2^|R|
    PowerSetCardinality(R);

      // PowerSetStep partitions PowerSet(S) into two families:
      // those that exclude x and those that include x. The first 
      // family is PowerSet(R), while the second is obtained by 
      // adding x to every subset of R. 
    PowerSetStep(R, x);

      // The cardinality of the disjoint union is the sum of the
      // cardinalities of the two families.
    DisjointUnionCardinality(PowerSet(R), AddToEach(x, PowerSet(R)));

      // Adding x to every subset of R preserves the number of subsets,
      // so both families have the same cardinality.
    AddedSubsetsCardinality(R, x);

    calc
    {
      |PowerSet(S)|;
        // Reconstruct S as R ∪ {x}
      == |PowerSet(R + {x})|;
        // Apply PowerSetStep: partition the power set into two families
      == |PowerSet(R) + AddToEach(x, PowerSet(R))|;
        // The two families are disjoint, so the cardinality of 
        // their union is the sum of their cardinalities
      == |PowerSet(R)| + |AddToEach(x, PowerSet(R))|;
        // Both families have the same cardinality
      == |PowerSet(R)| + |PowerSet(R)|;
        // Combine the two equal terms
      == 2 * |PowerSet(R)|;
        // Apply the induction hypothesis
      == 2 * Pow2(|R|);
        // Fold the recursive definition of Pow2
      == Pow2(|R| + 1);
        // Since S = R ∪ {x} and x ∉ R, we have |R| + 1 = |S|
      == Pow2(|S|);
    }
  }
}
