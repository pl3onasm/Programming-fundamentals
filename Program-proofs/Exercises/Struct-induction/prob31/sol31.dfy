/*  file: sol31.dfy
    author: David De Potter
    description: proof by structural induction that an expression tree
      has one more constant leaf than operator nodes
*/

include "../../Support/Datatypes/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves by structural induction on expr that it contains exactly one
// more constant leaf than operator nodes:
//   ConstCount(expr) = OpCount(expr) + 1
lemma {:induction false} ConstantOpCount(expr:Expr)
  ensures ConstCount(expr) == OpCount(expr) + 1
  decreases expr
{
  match expr

    // Base case: Q(Const(val)) is true
  case Const(val) =>
    calc
    {
      ConstCount(expr);
        // Replace expr by Const(val) 
      == ConstCount(Const(val));
        // Unfold ConstCount
      == 1;
        // Arithmetic
      == 0 + 1;
        // Fold OpCount(Const(val))
      == OpCount(Const(val)) + 1;
        // Replace Const(val) by expr
      == OpCount(expr) + 1;
    }

    // First inductive case: Q(left) ∧ Q(right) ⇒ Q(Add(left, right))
  case Add(left, right) =>
      // Induction hypotheses
      //   Assume Q(left) and Q(right) are true:
      //   ConstCount(left)  = OpCount(left) + 1
      //   ConstCount(right) = OpCount(right) + 1
    ConstantOpCount(left);
    ConstantOpCount(right);

      // Prove Q(Add(left, right)) is true
    calc
    {
      ConstCount(expr);
        // Replace expr by Add(left, right) 
      == ConstCount(Add(left, right));
        // Unfold ConstCount
      == ConstCount(left) + ConstCount(right);
        // Apply both induction hypotheses
      == (OpCount(left) + 1) + (OpCount(right) + 1);
        // Regroup the terms
      == (1 + OpCount(left) + OpCount(right)) + 1;
        // Fold OpCount
      == OpCount(Add(left, right)) + 1;
        // Replace Add(left, right) by expr
      == OpCount(expr) + 1;
    }

    // Second inductive case: Q(left) ∧ Q(right) ⇒ Q(Mul(left, right))
  case Mul(left, right) =>
      // Induction hypotheses
      //   Assume Q(left) and Q(right) are true:
      //   ConstCount(left)  = OpCount(left) + 1
      //   ConstCount(right) = OpCount(right) + 1
    ConstantOpCount(left);
    ConstantOpCount(right);

      // Prove Q(Mul(left, right)) is true
    calc
    {
      ConstCount(expr);
        // Replace expr by Mul(left, right)
      == ConstCount(Mul(left, right));
        // Unfold ConstCount
      == ConstCount(left) + ConstCount(right);
        // Apply both induction hypotheses
      == (OpCount(left) + 1) + (OpCount(right) + 1);
        // Regroup the terms
      == (1 + OpCount(left) + OpCount(right)) + 1;
        // Fold OpCount
      == OpCount(Mul(left, right)) + 1;
        // Replace Mul(left, right) by expr
      == OpCount(expr) + 1;
    }
}
