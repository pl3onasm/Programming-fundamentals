/*  file: prob34.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob34

    NOTE:
    A function f is idempotent when applying it twice has the same effect
    as applying it once: f(f(x)) = f(x). In this exercise, we prove that
    Simplify is idempotent.
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves that Simplify is idempotent:
//   Simplify(Simplify(expr)) = Simplify(expr)
lemma {:induction false} SimplifyIdempotent(expr:Expr)
  ensures Simplify(Simplify(expr)) == Simplify(expr)
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):

        Show that simplifying a constant twice has the same result as
        simplifying it once.

      First inductive case, Q(left) ∧ Q(right) ⇒ Q(Add(left, right)):
      
        Apply both induction hypotheses. Distinguish whether both results
        are constants. If they are, SimplifyAdd replaces their addition
        with a Const node. Otherwise, it leaves an Add node in place.

      Second inductive case, Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):
      
        Use the analogous argument for SimplifyMul.

  */
}
