/*  file: prob11.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob11
*/

include "../prob08/sol08.dfy"
include "../prob09/sol09.dfy"

//========================================================================
// Proves that Peano addition is commutative:  Add(p, q) = Add(q, p)
lemma {:induction false} AddCommutative(p:Peano, q:Peano)
  ensures Add(p, q) == Add(q, p)
  decreases p
{
  /*
    Prove this lemma by structural induction on p.

      Base case, Q(Zero):
        Show that  Add(Zero,q) = Add(q,Zero)
    
      Inductive case, Q(prev) ⇒ Q(Succ(prev)):
        Assume that  Add(prev, q) = Add(q, prev)
        and prove that
          Add(Succ(prev), q) = Add(q, Succ(prev))
    
    Use AddRightIdentity from the solution to problem08 in the base
    case, and AddSuccessorRight from the solution to problem09 in the
    inductive case. Both lemmas are included above.
  */
}
