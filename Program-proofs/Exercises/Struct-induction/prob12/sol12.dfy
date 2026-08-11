/*  file: sol12.dfy
    author: David De Potter
    description: proof by structural induction that Peano multiplication
      distributes over addition in its first argument
*/

include "../prob10/sol10.dfy"

//========================================================================
// Proves by structural induction on p that Peano multiplication
// distributes over addition in its first argument:
//   Mul(Add(p, q), r) = Add(Mul(p, r), Mul(q, r))
lemma {:induction false} MulDistributesOverAdd(p:Peano, q:Peano, r:Peano)
  ensures Mul(Add(p, q), r) == Add(Mul(p, r), Mul(q, r))
  decreases p
{
  if p == Zero
  {
      // Base case: Q(Zero) is true
    assert Mul(Add(p, q), r) == Add(Mul(p, r), Mul(q, r)) by
    {
      calc
      {
        Mul(Add(p, q), r);
          // p is Zero
        == Mul(Add(Zero,q), r);
          // Unfold Add(Zero, q)
        == Mul(q, r);
          // Introduce Zero as the first argument of Add
        == Add(Zero, Mul(q, r));
          // Fold Mul(Zero, r)
        == Add(Mul(Zero, r), Mul(q, r));
          // Replace Zero by p
        == Add(Mul(p, r), Mul(q, r));
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
      //   Mul(Add(prev, q), r) = Add(Mul(prev, r), Mul(q, r))
    MulDistributesOverAdd(prev, q, r);

      // Regroup the three additions used in the inductive calculation
    AddAssociative(r, Mul(prev, r), Mul(q, r));
    
      // Inductive case
      // Prove Q(Succ(prev)) is true
    calc
    {
      Mul(Add(p, q), r);
        // Replace p by Succ(prev)
      == Mul(Add(Succ(prev), q), r);
        // Unfold Add on its first argument
      == Mul(Succ(Add(prev, q)), r);
        // Unfold Mul on its first argument
      == Add(r, Mul(Add(prev, q), r));
        // Apply the induction hypothesis
      == Add(r, Add(Mul(prev, r), Mul(q, r)));
        // Apply AddAssociative in reverse direction
      == Add(Add(r, Mul(prev, r)), Mul(q, r));
        // Fold Mul(Succ(prev), r)
      == Add(Mul(Succ(prev), r), Mul(q, r));
        // Replace Succ(prev) by p
      == Add(Mul(p, r), Mul(q, r));
    }
  }
}