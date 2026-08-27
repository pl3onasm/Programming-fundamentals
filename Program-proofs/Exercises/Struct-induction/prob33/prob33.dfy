/*  file: prob33.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    problem 33

    NOTE:
    This exercise examines the simplification of constant additions and
    multiplications in expression trees.
    The Simplify function recursively simplifies both operands and
    then evaluates the operation and replaces it with a Const node
    whenever the resulting operands are constants. The proof shows 
    that the complete transformation preserves the evaluation of the
    original expression.
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves that full constant folding does not change the value of an
// expression:  Eval(Simplify(expr)) = Eval(expr)
lemma {:induction false} SimplifyCorrect(expr:Expr)
  ensures Eval(Simplify(expr)) == Eval(expr)
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):

        Show that simplifying a constant preserves its value.

      First inductive case, Q(left) ∧ Q(right) ⇒ Q(Add(left, right)):

        Apply the induction hypotheses to both operands. 

      Second inductive case, Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):

        Apply the induction hypotheses to both operands. 
  */
}
