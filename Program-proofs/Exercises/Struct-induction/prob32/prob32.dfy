/*  file: prob32.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob32
*/

include "../../Support/Datatypes/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves that mirroring an arithmetic expression does not change its
// value:  Eval(MirrorExpr(expr)) = Eval(expr)
lemma {:induction false} MirrorEval(expr:Expr)
  ensures Eval(MirrorExpr(expr)) == Eval(expr)
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):

        Show that Eval(MirrorExpr(Const(value))) = Eval(Const(value))

      First inductive case, Q(left) ∧ Q(right) ⇒ Q(Add(left, right)):

        Assume that mirroring left and right preserves their values,
        and prove the same property for their addition.

      Second inductive case, Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):

        Assume that mirroring left and right preserves their values,
        and prove the same property for their multiplication.

  */
}
