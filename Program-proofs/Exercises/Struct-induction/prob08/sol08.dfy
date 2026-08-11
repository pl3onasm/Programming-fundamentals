/*  file: sol08.dfy
    author: David De Potter
    description: proof by structural induction that Zero is a right
      identity for Peano addition
*/

include "../../Support/Datatypes/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves by structural induction on p that Zero is a right identity for
// Peano addition:  Add(p, Zero) = p
lemma {:induction false} AddRightIdentity(p:Peano)
  ensures Add(p,Zero) == p
  decreases p
{
  if p == Zero
  {
      // Base case: Q(Zero) is true
    assert Add(p, Zero) == p by
    {
      calc
      {
        Add(p, Zero);
          // p is Zero
        == Add(Zero, Zero);
          // Unfold Add
        == Zero;
          // Replace Zero by p
        == p;
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
      // Assume Q(prev) is true:  Add(prev, Zero) = prev
    AddRightIdentity(prev);

      // Inductive case
      // Prove Q(Succ(prev)) is true
    calc
    {
      Add(p, Zero);
        // Since p = Succ(prev)
      == Add(Succ(prev), Zero);
        // Unfold Add on its first argument
      == Succ(Add(prev, Zero));
        // Apply the induction hypothesis
      == Succ(prev);
        // Since p = Succ(prev)
      == p;
    }
  }
}
