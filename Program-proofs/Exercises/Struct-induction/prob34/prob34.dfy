/*  file: prob34.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob34

    NOTE:
    A function f is idempotent when applying it twice has the same effect
    as applying it once: f(f(x)) = f(x). In this exercise, we prove that
    Simplify is idempotent.

    The solution to problem34 is included, so we already know that
    Simplify(expr) is fully simplified. We will first prove that every
    fully simplified expression is a fixed point of Simplify, meaning that
    Simplify leaves it unchanged. Applying this fixed-point property to
    Simplify(expr) then proves idempotence.
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves that every fully simplified expression is a fixed point of
// Simplify: applying Simplify leaves the expression unchanged.
lemma {:induction false} SimplifiedFixedPoint(expr:Expr)
  requires IsSimplified(expr)
  ensures  Simplify(expr) == expr
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):
        Show that Simplify(Const(value)) = Const(value).

      First inductive case,
      Q(left) ∧ Q(right) ⇒ Q(Add(left, right)):
        IsSimplified(expr) tells us that left and right are fully
        simplified and are not both constants. Apply both induction
        hypotheses. SimplifyAdd then leaves their addition unchanged.

      Second inductive case,
      Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):
        Use the analogous argument for SimplifyMul.
  */
}

//========================================================================
// Proves that Simplify is idempotent:
//   Simplify(Simplify(expr)) = Simplify(expr)
lemma SimplifyIdempotent(expr:Expr)
  ensures Simplify(Simplify(expr)) == Simplify(expr)
{
  /*
    Apply SimplifyProducesSimplified from problem34 to show that
    Simplify(expr) is fully simplified. Then apply SimplifiedFixedPoint
    to that result.
  */
}
