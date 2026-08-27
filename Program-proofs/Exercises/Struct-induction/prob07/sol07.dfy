/*  file: sol07.dfy
    author: David De Potter
    description: proof by structural induction that converting a Peano
      number to a natural number and back preserves its value
*/

include "../../Support/Datatypes/Finite/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves by structural induction on p that converting p to a natural
// number and back again returns p:  PeanoFromNat(PeanoToNat(p)) = p
lemma {:induction false} PeanoConversionIdentity(p:Peano)
  ensures PeanoFromNat(PeanoToNat(p)) == p
  decreases p
{
  if p == Zero
  {
      // Base case: Q(Zero) is true
    assert PeanoFromNat(PeanoToNat(p)) == p by
    {
      calc
      {
        PeanoFromNat(PeanoToNat(p));
          // Since p = Zero
        == PeanoFromNat(PeanoToNat(Zero));
          // Unfold PeanoToNat
        == PeanoFromNat(0);
          // Unfold PeanoFromNat
        == Zero;
          // Replace Zero by p
        == p;
      }
    }
  }

  else
  {
      // Since p ≠ Zero, it has the form Succ(p.prev).
      // Let prev denote this structurally smaller Peano number,
      // to which the induction hypothesis applies.
    var prev := p.prev;

      // Induction hypothesis
      // Assume Q(prev) is true:
      //   PeanoFromNat(PeanoToNat(prev)) = prev
    PeanoConversionIdentity(prev);

      // Inductive case
      // Prove Q(Succ(prev)) is true
    calc
    {
      PeanoFromNat(PeanoToNat(p));
        // Since p = Succ(prev)
      == PeanoFromNat(PeanoToNat(Succ(prev)));
        // Unfold PeanoToNat
      == PeanoFromNat(PeanoToNat(prev) + 1);
        // Unfold PeanoFromNat 
      == Succ(PeanoFromNat(PeanoToNat(prev)));
        // Apply the induction hypothesis
      == Succ(prev);
        // Replace Succ(prev) by p
      == p;
    }
  }
}
