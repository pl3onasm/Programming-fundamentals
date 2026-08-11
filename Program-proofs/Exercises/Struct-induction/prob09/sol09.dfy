/*  file: sol09.dfy
    author: David De Potter
    description: proof by structural induction of addition with a
      successor as its second argument
*/

include "../../Support/Datatypes/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves by structural induction on p that adding a successor as the
// second argument is equivalent to taking the successor after addition:
//   Add(p,Succ(q)) = Succ(Add(p,q))
lemma {:induction false} AddSuccessorRight(p:Peano, q:Peano)
  ensures Add(p,Succ(q)) == Succ(Add(p,q))
  decreases p
{
  if p == Zero
  {
      // Base case: Q(Zero) is true
    assert Add(p,Succ(q)) == Succ(Add(p,q)) by
    {
      calc
      {
        Add(p,Succ(q));
          // p is Zero
        == Add(Zero,Succ(q));
          // Unfold Add
        == Succ(q);
          // Fold Add
        == Succ(Add(Zero,q));
          // Replace Zero by p
        == Succ(Add(p,q));
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
      //   Add(prev, Succ(q)) = Succ(Add(prev, q))
    AddSuccessorRight(prev, q);

      // Inductive case
      // Prove Q(Succ(prev)) is true
    calc
    {
      Add(p, Succ(q));
        // Replace p by Succ(prev)
      == Add(Succ(prev), Succ(q));
        // Unfold Add on its first argument
      == Succ(Add(prev, Succ(q)));
        // Apply the induction hypothesis
      == Succ(Succ(Add(prev, q)));
        // Fold Add(Succ(prev),q)
      == Succ(Add(Succ(prev), q));
        // Replace Succ(prev) by p
      == Succ(Add(p, q));
    }
  }
}