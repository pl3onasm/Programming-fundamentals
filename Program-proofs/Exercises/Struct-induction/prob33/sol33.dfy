/*  file: sol33.dfy
    author: David De Potter
    description: proof by structural induction that simplifying all
      constant operations preserves the value of arithmetic expressions
*/

include "../../Support/Datatypes/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves by structural induction on expr that full constant folding does
// not change its value:  Eval(Simplify(expr)) = Eval(expr)
lemma {:induction false} SimplifyCorrect(expr:Expr)
  ensures Eval(Simplify(expr)) == Eval(expr)
  decreases expr
{
  match expr

    // Base case: Q(Const(value)) is true
  case Const(value) =>  
    calc
    {
      Eval(Simplify(expr));
        // Replace expr by Const(value)
      == Eval(Simplify(Const(value)));
        // Unfold Simplify
      == Eval(Const(value));
        // Replace Const(value) by expr
      == Eval(expr);
    }

    // First inductive case: Q(left) ∧ Q(right) ⇒ Q(Add(left, right))
  case Add(left, right) =>
      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   Eval(Simplify(left))  = Eval(left)
      //   Eval(Simplify(right)) = Eval(right)
    SimplifyCorrect(left);
    SimplifyCorrect(right);

      // Prove Q(Add(left, right)) is true
    calc
    {
      Eval(Simplify(expr));
        // Replace expr by Add(left, right)
      == Eval(Simplify(Add(left, right)));
        // Unfold Simplify
      == Eval(SimplifyAdd(Simplify(left), Simplify(right)));
        // If both simplified operands are constants, SimplifyAdd returns
        // a Const node containing their sum; otherwise, it returns an Add
        // node containing those operands. Evaluating either result gives
        // the sum of the evaluations of the simplified operands.
      == Eval(Simplify(left)) + Eval(Simplify(right));
        // Apply both induction hypotheses
      == Eval(left) + Eval(right);
        // Fold Eval(Add(left, right))
      == Eval(Add(left, right));
        // Replace Add(left, right) by expr
      == Eval(expr);
    }

    // Second inductive case: Q(left) ∧ Q(right) ⇒ Q(Mul(left, right))
  case Mul(left, right) =>
      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   Eval(Simplify(left))  = Eval(left)
      //   Eval(Simplify(right)) = Eval(right)
    SimplifyCorrect(left);
    SimplifyCorrect(right);

      // Prove Q(Mul(left, right)) is true
    calc
    {
      Eval(Simplify(expr));
        // Replace expr by Mul(left, right)
      == Eval(Simplify(Mul(left, right)));
        // Unfold Simplify
      == Eval(SimplifyMul(Simplify(left), Simplify(right)));
        // If both simplified operands are constants, SimplifyMul returns
        // a Const node containing their product; otherwise, it returns a
        // Mul node containing those operands. Evaluating either result
        // gives the product of the evaluations of the simplified operands
      == Eval(Simplify(left)) * Eval(Simplify(right));
        // Apply both induction hypotheses
      == Eval(left) * Eval(right);
        // Fold Eval(Mul(left, right))
      == Eval(Mul(left, right));
        // Replace Mul(left, right) by expr
      == Eval(expr);
    }
}
