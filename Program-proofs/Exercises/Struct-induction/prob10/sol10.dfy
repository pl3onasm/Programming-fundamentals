/*  file: sol10.dfy
    author: David De Potter
    description: proof by structural induction that Peano addition is
      associative
*/

include "../../Support/Datatypes/Finite/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves by structural induction on p that Peano addition is associative:
//   Add(Add(p, q), r) = Add(p, Add(q, r))
lemma {:induction false} AddAssociative(p:Peano, q:Peano, r:Peano)
  ensures Add(Add(p, q), r) == Add(p, Add(q, r))
  decreases p
{
  if p == Zero
  {
      // Base case: Q(Zero) is true
    assert Add(Add(p, q), r) == Add(p, Add(q, r)) by
    {
      calc
      {
        Add(Add(p, q), r);
          // p is Zero
        == Add(Add(Zero, q), r);
          // Unfold the inner application of Add
        == Add(q, r);
          // Zero is a left identity for Add
        == Add(Zero, Add(q, r));
          // Replace Zero by p
        == Add(p, Add(q, r));
      }
    }
  }

  else
  {
      // Since p ≠ Zero, it has the form Succ(p.prev).
      // Let prev denote this structurally smaller Peano 
      // number, to which the induction hypothesis applies.
    var prev := p.prev;

      // Induction hypothesis
      // Assume Q(prev) is true:
      //   Add(Add(prev, q), r) = Add(prev, Add(q, r))
    AddAssociative(prev, q, r);

      // Inductive case
      // Prove Q(Succ(prev)) is true
    calc
    {
      Add(Add(p, q), r);
        // Replace p by Succ(prev)
      == Add(Add(Succ(prev), q), r);
        // Unfold the inner application of Add
      == Add(Succ(Add(prev, q)), r);
        // Unfold the outer application of Add
      == Succ(Add(Add(prev, q), r));
        // Apply the induction hypothesis
      == Succ(Add(prev, Add(q, r)));
        // Fold on its first argument
      == Add(Succ(prev), Add(q, r));
        // Replace Succ(prev) by p
      == Add(p, Add(q, r));
    }
  }
}