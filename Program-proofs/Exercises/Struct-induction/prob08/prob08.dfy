/*  file: prob08.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob08
*/

include "../../Support/Datatypes/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves that Zero is a right identity for Peano addition:
//   Add(p, Zero) = p
lemma {:induction false} AddRightIdentity(p:Peano)
  ensures Add(p, Zero) == p
  decreases p
{
  /*
    Prove this lemma by structural induction on p.
      
      Base case, Q(Zero):
        Show that  Add(Zero, Zero) = Zero

      Inductive case, Q(prev) ⇒ Q(Succ(prev)):
        Assume that  Add(prev, Zero) = prev
        and prove that
          Add(Succ(prev), Zero) = Succ(prev)

    Recall that Add recurses on its first argument. Although the left
    identity Add(Zero, p) = p follows directly from its definition, 
    the corresponding right-identity property requires induction.

  */
}