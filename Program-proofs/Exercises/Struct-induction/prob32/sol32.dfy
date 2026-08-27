/*  file: sol32.dfy
    author: David De Potter
    description: proof by structural induction that mirroring an
      arithmetic expression preserves its value
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves by structural induction on expr that mirroring it does not
// change its value:  Eval(MirrorExpr(expr)) = Eval(expr)
lemma {:induction false} MirrorEval(expr:Expr)
  ensures Eval(MirrorExpr(expr)) == Eval(expr)
  decreases expr
{
  match expr

    // Base case: Q(Const(val)) is true
  case Const(val) =>
    calc
    {
      Eval(MirrorExpr(expr));
        // Replace expr by Const(val)
      == Eval(MirrorExpr(Const(val)));
        // Unfold MirrorExpr
      == Eval(Const(val));
        // Replace Const(val) by expr
      == Eval(expr);
    }

    // First inductive case: Q(left) ∧ Q(right) ⇒ Q(Add(left, right))
  case Add(left, right) =>
      // Induction hypotheses
      //   Assume Q(left) and Q(right) are true:
      //   Eval(MirrorExpr(left))  = Eval(left)
      //   Eval(MirrorExpr(right)) = Eval(right)
    MirrorEval(left);
    MirrorEval(right);

      // Prove Q(Add(left, right)) is true
    calc
    {
      Eval(MirrorExpr(expr));
        // Replace expr by Add(left, right)
      == Eval(MirrorExpr(Add(left, right)));
        // Unfold MirrorExpr
      == Eval(Add(MirrorExpr(right), MirrorExpr(left)));
        // Unfold Eval
      == Eval(MirrorExpr(right)) + Eval(MirrorExpr(left));
        // Apply both induction hypotheses
      == Eval(right) + Eval(left);
        // Integer addition is commutative
      == Eval(left) + Eval(right);
        // Fold Eval(Add(left, right))
      == Eval(Add(left, right));
        // Replace Add(left, right) by expr
      == Eval(expr);
    }

    // Second inductive case: Q(left) ∧ Q(right) ⇒ Q(Mul(left, right))
  case Mul(left, right) =>
      // Induction hypotheses
      //   Assume Q(left) and Q(right) are true:
      //   Eval(MirrorExpr(left))  = Eval(left)
      //   Eval(MirrorExpr(right)) = Eval(right)
    MirrorEval(left);
    MirrorEval(right);

      // Prove Q(Mul(left, right)) is true
    calc
    {
      Eval(MirrorExpr(expr));
        // Replace expr by Mul(left, right)
      == Eval(MirrorExpr(Mul(left, right)));
        // Unfold MirrorExpr
      == Eval(Mul(MirrorExpr(right), MirrorExpr(left)));
        // Unfold Eval
      == Eval(MirrorExpr(right)) * Eval(MirrorExpr(left));
        // Apply both induction hypotheses
      == Eval(right) * Eval(left);
        // Integer multiplication is commutative
      == Eval(left) * Eval(right);
        // Fold Eval(Mul(left, right))
      == Eval(Mul(left, right));
        // Replace Mul(left, right) by expr
      == Eval(expr);
    }
}
