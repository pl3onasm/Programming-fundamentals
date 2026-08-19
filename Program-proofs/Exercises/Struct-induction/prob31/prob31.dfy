/*  file: prob31.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob31
*/

include "../../Support/Datatypes/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves that an arithmetic expression tree contains exactly one more
// constant leaf than operator nodes:
//   ConstantCount(expr) = OperatorCount(expr) + 1
lemma {:induction false} ConstantOperatorCount(expr:Expr)
  ensures ConstantCount(expr) == OperatorCount(expr) + 1
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):

        Show that   ConstantCount(Const(value))
                    = OperatorCount(Const(value)) + 1

      First inductive case, (left) ∧ Q(right) ⇒ Q(Add(left, right)):

        Assume that each operand has one more constant than operators,
        and prove the same property for their addition.

      Second inductive case, Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):

        Assume that each operand has one more constant than operators,
        and prove the same property for their multiplication.

    In both inductive cases, apply the lemma recursively to the two
    structurally smaller operands. Joining their trees beneath one new
    operator preserves the difference of one between the two counts.
  */
}
