/*  file: prob07.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob07
*/

include "../../Support/Datatypes/PeanoNumbers.dfy"
import opened PeanoNumbers

//========================================================================
// Proves that converting a Peano number to a natural number and
// back again returns the original Peano number.
lemma {:induction false} PeanoConversionIdentity(p:Peano)
  ensures PeanoFromNat(PeanoToNat(p)) == p
  decreases p
{
  /*
    Prove this lemma by structural induction on p.
      
      Base case, Q(Zero):
      
        Show that     PeanoFromNat(PeanoToNat(Zero)) = Zero
      
      Inductive case, Q(prev) ⇒ Q(Succ(prev)):

        Assume that   PeanoFromNat(PeanoToNat(prev)) = prev

        Prove that    PeanoFromNat(PeanoToNat(Succ(prev))) = Succ(prev)

    Distinguish the two structural cases by testing whether p = Zero.
    Otherwise, p has the form Succ(prev), where prev = p.prev denotes the
    structurally smaller Peano number to which the induction hypothesis
    applies.
    
  */
}