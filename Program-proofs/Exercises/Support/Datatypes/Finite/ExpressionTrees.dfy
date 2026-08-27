/*  file: ExpressionTrees.dfy
    author: David De Potter
    description: definition and evaluation of simple 
      arithmetic expression trees
*/
module ExpressionTrees
{
  //======================================================================
  // Represents arithmetic expressions as binary trees. A leaf contains
  // an integer constant, while an internal node represents addition or
  // multiplication of its two subexpressions. For example, the expression
  // 2 + 3 * 4 is represented by: Add(Const(2), Mul(Const(3), Const(4)))
  datatype Expr = Const(value:int)
                | Add(left:Expr, right:Expr)
                | Mul(left:Expr, right:Expr)

  //======================================================================
  // Evaluates an arithmetic expression recursively:
  //   Eval(Const(value))     = value
  //   Eval(Add(left, right)) = Eval(left) + Eval(right)
  //   Eval(Mul(left, right)) = Eval(left) * Eval(right)
  function Eval(expr:Expr): int
    decreases expr
  {
    match expr
    case  Const(value)     => value
    case  Add(left, right) => Eval(left) + Eval(right)
    case  Mul(left, right) => Eval(left) * Eval(right)
  }

  //======================================================================
  // Mirrors an expression tree by recursively exchanging the left and
  // right operands of every addition and multiplication node.
  function MirrorExpr(expr:Expr): Expr
    decreases expr
  {
    match expr
    case  Const(value)     => Const(value)
    case  Add(left, right) => Add(MirrorExpr(right), MirrorExpr(left))
    case  Mul(left, right) => Mul(MirrorExpr(right), MirrorExpr(left))
  }

  //======================================================================
  // Counts the constant leaves in an expression tree.
  function ConstCount(expr:Expr): nat
    decreases expr
  {
    match expr
    case  Const(_)         => 1
    case  Add(left, right) => ConstCount(left) + ConstCount(right)
    case  Mul(left, right) => ConstCount(left) + ConstCount(right)
  }

  //======================================================================
  // Counts the operator nodes in an expression tree. Both addition and
  // multiplication contribute one operator node.
  function OpCount(expr:Expr): nat
    decreases expr
  {
    match expr
    case  Const(_)         => 0
    case  Add(left, right) => 1 + OpCount(left) + OpCount(right)
    case  Mul(left, right) => 1 + OpCount(left) + OpCount(right)
  }

  //======================================================================
  // Replaces an addition by its constant result when both operands are
  // constants. Otherwise, it leaves the addition in place.
  // The constructor query left.Const? tests whether left was constructed
  // using Const. In that case, left.value denotes its stored integer.
  function SimplifyAdd(left:Expr, right:Expr): Expr
  {
    if left.Const? && right.Const? 
    then
      Const(left.value + right.value)
    else
      Add(left, right)
  }

  //======================================================================
  // Replaces a multiplication by its constant result when both operands
  // are constants. Otherwise, it leaves the multiplication in place.
  function SimplifyMul(left:Expr, right:Expr): Expr
  {
    if left.Const? && right.Const? 
    then
      Const(left.value * right.value)
    else
      Mul(left, right)
  }

  //========================================================================
  // Simplifies all constant additions and multiplications in an expression
  // tree. Both operands are simplified before a constant operation is
  // evaluated and replaced by a single Const node.
  function Simplify(expr:Expr): Expr
    decreases expr
  {
    match expr
    case  Const(value)     => Const(value)
    case  Add(left, right) => SimplifyAdd(Simplify(left), Simplify(right))
    case  Mul(left, right) => SimplifyMul(Simplify(left), Simplify(right))
  }

  //======================================================================
  // Determines whether an expression contains no remaining constant
  // operation that Simplify could evaluate. A Const node is always fully
  // simplified. An Add or Mul node is fully simplified when both of its
  // operands are fully simplified and at least one operand is not a Const
  // node. If both operands were constants, Simplify would replace the
  // operation by a single Const node containing its result.
  //   IsSimplified(Const(value))     = true
  //   IsSimplified(Add(left,right)) = IsSimplified(left)
  //                                   and IsSimplified(right)
  //                                   and not both operands are constants 
  //   IsSimplified(Mul(left,right)) = IsSimplified(left)
  //                                   and IsSimplified(right)
  //                                   and not both operands are constants
  // 
  predicate IsSimplified(expr:Expr)
    decreases expr
  {
    match expr
    case Const(_) => true
    case Add(left, right) =>
      IsSimplified(left) &&
      IsSimplified(right) &&
      !(left.Const? && right.Const?)
    case Mul(left, right) =>
      IsSimplified(left) &&
      IsSimplified(right) &&
      !(left.Const? && right.Const?)
}

}