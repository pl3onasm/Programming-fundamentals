/*  file: sol11.dfy
    author: David De Potter
    description: proof by structural induction that Peano addition is
      commutative
*/

include "../prob08/sol08.dfy"
include "../prob09/sol09.dfy"

//========================================================================
// Proves by structural induction on p that Peano addition is commutative:
//   Add(p, q) = Add(q, p)
lemma {:induction false} AddCommutative(p:Peano, q:Peano)
  ensures Add(p, q) == Add(q, p)
  decreases p
{
  if p == Zero
  {
      // Establish that Zero is also a right identity for Add
    AddRightIdentity(q);

      // Base case: Q(Zero) is true
    assert Add(p, q) == Add(q, p) by
    {
      calc
      {
        Add(p, q);
          // p is Zero
        == Add(Zero, q);
          // Unfold Add(Zero, q)
        == q;
          // Apply AddRightIdentity
        == Add(q,Zero);
          // Replace Zero by p
        == Add(q,p);
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
      // Assume Q(prev) is true:  Add(prev, q) = Add(q, prev)
    AddCommutative(prev, q);

      // Rewrite addition with Succ(prev) as its second argument
    AddSuccessorRight(q, prev);

      // Inductive case
      // Prove Q(Succ(prev)) is true
    calc
    {
      Add(p, q);
        // Replace p by Succ(prev)
      == Add(Succ(prev), q);
        // Unfold Add on its first argument
      == Succ(Add(prev, q));
        // Apply the induction hypothesis
      == Succ(Add(q, prev));
        // Apply AddSuccessorRight in reverse direction
      == Add(q, Succ(prev));
        // Replace Succ(prev) by p
      == Add(q, p);
    }
  }
}
