/*  file: prob12.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob12
*/

include "../prob10/sol10.dfy"

//========================================================================
// Proves that Peano multiplication distributes over addition in its
// first argument:   Mul(Add(p, q), r) = Add(Mul(p, r), Mul(q, r))
lemma {:induction false} MulDistributesOverAdd(p:Peano, q:Peano, r:Peano)
  ensures Mul(Add(p, q), r) == Add(Mul(p, r), Mul(q, r))
  decreases p
{
  /*
    Prove this lemma by structural induction on p.

      Base case, Q(Zero):
        Show that
          Mul(Add(Zero, q), r)
          = Add(Mul(Zero, r), Mul(q, r))

      Inductive case, Q(previous) ⇒ Q(Succ(previous)):
        Assume that
          Mul(Add(previous, q), r)
          = Add(Mul(previous, r), Mul(q, r))
        and prove that
          Mul(Add(Succ(previous), q), r)
          = Add(Mul(Succ(previous), r), Mul(q, r))

    Use AddAssociative from the solution to problem10 to regroup 
    the three additions in the inductive case.
  */
}
