/*  file: prob10.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob10
*/

include "../../Support/Datatypes/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves that Peano addition is associative:
//   Add(Add(p, q), r) = Add(p, Add(q, r))
lemma {:induction false} AddAssociative(p:Peano, q:Peano, r:Peano)
  ensures Add(Add(p,q),r) == Add(p,Add(q,r))
  decreases p
{
  /*
    Prove this lemma by structural induction on p.

      Base case, Q(Zero):
        Show that  Add(Add(Zero, q), r) = Add(Zero, Add(q, r))

      Inductive case, Q(prev) ⇒ Q(Succ(prev)):
        Assume that  Add(Add(prev, q), r) = Add(prev, Add(q, r))
        and prove that
            Add(Add(Succ(prev), q), r)
          = Add(Succ(prev), Add(q, r))

  */
}
