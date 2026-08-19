/*  file: prob09.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob09
*/

include "../../Support/Datatypes/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves how addition behaves when its second argument is a successor:
//   Add(p, Succ(q)) = Succ(Add(p, q))
lemma {:induction false} AddSuccessorRight(p:Peano, q:Peano)
  ensures Add(p, Succ(q)) == Succ(Add(p, q))
  decreases p
{
  /*
    Prove this lemma by structural induction on p.

      Base case, Q(Zero):
      
        Show that     Add(Zero, Succ(q)) = Succ(Add(Zero, q))

      Inductive case, Q(prev) ⇒ Q(Succ(prev)):

        Assume that   Add(prev, Succ(q)) = Succ(Add(prev, q))

        Prove that    Add(Succ(prev), Succ(q)) = Succ(Add(Succ(prev), q))

    The induction is performed on p because the function Add recurses 
    on its first argument, even though the property we want to prove
    concerns the second argument.

  */
}
