/*  file: sol34.dfy
    author: David De Potter
    description: proof by structural induction that expression-tree
      simplification is idempotent
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves by structural induction on expr that every fully simplified
// expression is a fixed point of Simplify.
lemma {:induction false} SimplifiedFixedPoint(expr:Expr)
  requires IsSimplified(expr)
  ensures  Simplify(expr) == expr
  decreases expr
{
  match expr
  case Const(value) =>
      // Base case: Q(Const(value)) is true
    calc
    {
      Simplify(expr);
        // Replace expr by Const(value)
      == Simplify(Const(value));
        // Unfold Simplify
      == Const(value);
        // Replace Const(value) by expr
      == expr;
    }

  case Add(left, right) =>
      // Since expr is fully simplified, so are both operands, and they
      // are not both constants.

      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   Simplify(left)  = left
      //   Simplify(right) = right
    SimplifiedFixedPoint(left);
    SimplifiedFixedPoint(right);

    calc
    {
      Simplify(expr);
        // Replace expr by Add(left, right)
      == Simplify(Add(left, right));
        // Unfold Simplify
      == SimplifyAdd(Simplify(left), Simplify(right));
        // Apply both induction hypotheses
      == SimplifyAdd(left, right);
        // The operands are not both constants, so SimplifyAdd leaves
        // their addition in place
      == Add(left, right);
        // Replace Add(left, right) by expr
      == expr;
    }

  case Mul(left, right) =>
      // Since expr is fully simplified, so are both operands, and they
      // are not both constants.

      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   Simplify(left)  = left
      //   Simplify(right) = right
    SimplifiedFixedPoint(left);
    SimplifiedFixedPoint(right);

    calc
    {
      Simplify(expr);
        // Replace expr by Mul(left, right)
      == Simplify(Mul(left, right));
        // Unfold Simplify
      == SimplifyMul(Simplify(left), Simplify(right));
        // Apply both induction hypotheses
      == SimplifyMul(left, right);
        // The operands are not both constants, so SimplifyMul leaves
        // their multiplication in place
      == Mul(left, right);
        // Replace Mul(left, right) by expr
      == expr;
    }
}

//========================================================================
// Proves that Simplify is idempotent:
//   Simplify(Simplify(expr)) = Simplify(expr)
lemma SimplifyIdempotent(expr:Expr)
  ensures Simplify(Simplify(expr)) == Simplify(expr)
{
    // Problem34 proves that the first application of Simplify produces
    // a fully simplified expression.
  //SimplifyProducesSimplified(expr);

    // Simplify leaves that fully simplified result unchanged.
  //SimplifiedFixedPoint(Simplify(expr));
}
