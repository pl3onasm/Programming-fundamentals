/*  file: sol34.dfy
    author: David De Potter
    description: proof by structural induction that expression-tree
      simplification is idempotent
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Proves by structural induction on expr that applying Simplify twice has
// the same effect as applying it once:
//   Simplify(Simplify(expr)) = Simplify(expr)
lemma {:induction false} SimplifyIdempotent(expr:Expr)
  ensures Simplify(Simplify(expr)) == Simplify(expr)
  decreases expr
{
  match expr

      // Base case: Q(Const(value)) is true
  case Const(value) =>
    calc
    {
      Simplify(Simplify(expr));
        // Replace expr by Const(value)
      == Simplify(Simplify(Const(value)));
        // Unfold the inner application of Simplify
      == Simplify(Const(value));
        // Replace Const(value) by expr
      == Simplify(expr);
    }

    // First inductive case: Q(left) ∧ Q(right) ⇒ Q(Add(left, right))
  case Add(left, right) =>
      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   Simplify(Simplify(left))  = Simplify(left)
      //   Simplify(Simplify(right)) = Simplify(right)
    SimplifyIdempotent(left);
    SimplifyIdempotent(right);

      // Abbreviate the two simplified operands for readability
    var simpleLeft  := Simplify(left);
    var simpleRight := Simplify(right);

      // In terms of these abbreviations, the induction hypotheses state:
      //   Simplify(simpleLeft)  = simpleLeft
      //   Simplify(simpleRight) = simpleRight

    if simpleLeft.Const? && simpleRight.Const?
    {
        // SimplifyAdd replaces the addition of two constants with a
        // single constant. Simplifying that constant changes nothing,
        // so this subcase does not require the induction hypotheses.
      calc
      {
        Simplify(Simplify(expr));
          // Replace expr by Add(left, right)
        == Simplify(Simplify(Add(left, right)));
          // Unfold the inner application of Simplify
        == Simplify(SimplifyAdd(simpleLeft, simpleRight));
          // Both simplified operands are constants
        == Simplify(Const(simpleLeft.value + simpleRight.value));
          // Unfold the outer application of Simplify
        == Const(simpleLeft.value + simpleRight.value);
          // Fold SimplifyAdd
        == SimplifyAdd(simpleLeft, simpleRight);
          // Fold Simplify(Add(left, right))
        == Simplify(Add(left, right));
          // Replace Add(left, right) by expr
        == Simplify(expr);
      }
    }

    else
    {
        // Since the operands are not both constants, SimplifyAdd leaves
        // an Add node in place. The induction hypotheses show that its
        // already simplified operands remain unchanged.
      calc
      {
        Simplify(Simplify(expr));
          // Replace expr by Add(left, right)
        == Simplify(Simplify(Add(left, right)));
          // Unfold the inner application of Simplify
        == Simplify(SimplifyAdd(simpleLeft, simpleRight));
          // The operands are not both constants
        == Simplify(Add(simpleLeft, simpleRight));
          // Unfold the outer application of Simplify
        == SimplifyAdd(Simplify(simpleLeft), Simplify(simpleRight));
          // Apply the induction hypothesis for left
        == SimplifyAdd(simpleLeft, Simplify(simpleRight));
          // Apply the induction hypothesis for right
        == SimplifyAdd(simpleLeft, simpleRight);
          // Fold Simplify(Add(left, right))
        == Simplify(Add(left, right));
          // Replace Add(left, right) by expr
        == Simplify(expr);
      }
    }

    // Second inductive case: Q(left) ∧ Q(right) ⇒ Q(Mul(left, right))
  case Mul(left, right) =>
      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   Simplify(Simplify(left))  = Simplify(left)
      //   Simplify(Simplify(right)) = Simplify(right)
    SimplifyIdempotent(left);
    SimplifyIdempotent(right);

      // Abbreviate the two simplified operands for readability
    var simpleLeft  := Simplify(left);
    var simpleRight := Simplify(right);

      // In terms of these abbreviations, the induction hypotheses state:
      //   Simplify(simpleLeft)  = simpleLeft
      //   Simplify(simpleRight) = simpleRight

    if simpleLeft.Const? && simpleRight.Const?
    {
        // SimplifyMul replaces the multiplication of two constants with
        // a single constant. Simplifying that constant changes nothing,
        // so this subcase does not require the induction hypotheses.
      calc
      {
        Simplify(Simplify(expr));
          // Replace expr by Mul(left, right)
        == Simplify(Simplify(Mul(left, right)));
          // Unfold the inner application of Simplify
        == Simplify(SimplifyMul(simpleLeft, simpleRight));
          // Both simplified operands are constants
        == Simplify(Const(simpleLeft.value * simpleRight.value));
          // Unfold the outer application of Simplify
        == Const(simpleLeft.value * simpleRight.value);
          // Fold SimplifyMul
        == SimplifyMul(simpleLeft, simpleRight);
          // Fold Simplify(Mul(left, right))
        == Simplify(Mul(left, right));
          // Replace Mul(left, right) by expr
        == Simplify(expr);
      }
    }

    else
    {
        // Since the operands are not both constants, SimplifyMul leaves
        // a Mul node in place. The induction hypotheses show that its
        // already simplified operands remain unchanged.
      calc
      {
        Simplify(Simplify(expr));
          // Replace expr by Mul(left, right)
        == Simplify(Simplify(Mul(left, right)));
          // Unfold the inner application of Simplify
        == Simplify(SimplifyMul(simpleLeft, simpleRight));
          // The operands are not both constants
        == Simplify(Mul(simpleLeft, simpleRight));
          // Unfold the outer application of Simplify
        == SimplifyMul(Simplify(simpleLeft), Simplify(simpleRight));
          // Apply the induction hypothesis for left
        == SimplifyMul(simpleLeft, Simplify(simpleRight));
          // Apply the induction hypothesis for right
        == SimplifyMul(simpleLeft, simpleRight);
          // Fold Simplify(Mul(left, right))
        == Simplify(Mul(left, right));
          // Replace Mul(left, right) by expr
        == Simplify(expr);
      }
    }
}
