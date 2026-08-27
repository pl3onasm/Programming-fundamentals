/*  file: prob36.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob36

    NOTE:
    This final exercise verifies a small compiler for arithmetic
    expression trees. The compiler translates an expression into code
    for a stack machine. A constant pushes its value onto the stack,
    while an addition or multiplication combines the top two values.

    The Code datatype represents a linked sequence of instructions. Each
    instruction stores the code that must be executed next. The compiler
    receives this remaining code as its continuation and places the code
    for the expression in front of it. Using a continuation avoids having
    to append instruction sequences during compilation.

    The direct statement for a complete program is too weak to serve as
    the induction hypothesis, because recursive compiler calls use
    nonempty continuations and may begin with values already on the stack.
    We therefore prove a strengthened property for an arbitrary
    continuation and initial stack. It states that executing the compiled
    expression has the same effect as pushing its mathematical value and
    then executing the continuation.
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Represents code for a stack machine. Done ends execution. Push places
// a value on the stack. AddValues and MultiplyValues remove the top two
// values, combine them, and push the result. Every instruction contains
// the code that is executed next.
datatype Code = Done
              | Push(value:int, next:Code)
              | AddValues(next:Code)
              | MultiplyValues(next:Code)

//========================================================================
// Represents the result of executing stack-machine code. Failure denotes
// an attempt to apply an operation when fewer than two values are
// available. Success contains the final stack.
datatype ExecResult = Failure
                    | Success(stack:seq<int>)

//========================================================================
// Executes stack-machine code. The top of the stack is stored at index 0.
// After compiling a binary operation, the right operand is therefore at
// index 0 and the left operand at index 1. The operation replaces these
// two values by their result and then continues with the remaining code.
function Execute(code:Code, stack:seq<int>): ExecResult
  decreases code
{
  match code
  case Done => Success(stack)
  case Push(value, next) => Execute(next, [value] + stack)
  case AddValues(next) =>
    if |stack| < 2 then Failure
    else Execute(next, [stack[1] + stack[0]] + stack[2..])
  case MultiplyValues(next) =>
    if |stack| < 2 then Failure
    else Execute(next, [stack[1] * stack[0]] + stack[2..])
}

//========================================================================
// Compiles expr in front of continuation. The left operand is compiled
// first, followed by the right operand and the instruction that combines
// their values. Execution then proceeds with continuation.
function Compile(expr:Expr, continuation:Code): Code
  decreases expr
{
  match expr
  case Const(value) => Push(value, continuation)
  case Add(left, right) =>
    Compile(left, Compile(right, AddValues(continuation)))
  case Mul(left, right) =>
    Compile(left, Compile(right, MultiplyValues(continuation)))
}

//========================================================================
// Compiles a complete expression with no code following it.
function CompileExpression(expr:Expr): Code
{
  Compile(expr, Done)
}

//========================================================================
// Compiles and executes an expression, starting with an empty stack.
function Run(expr:Expr): ExecResult
{
  Execute(CompileExpression(expr), [])
}

//========================================================================
// Proves the strengthened compiler-correctness property. Executing the
// code for expr in front of an arbitrary continuation has the same effect
// as pushing Eval(expr) onto the initial stack and then executing that
// continuation.
lemma {:induction false} CompileCorrect(
  expr:Expr, continuation:Code, stack:seq<int>)
  ensures Execute(Compile(expr, continuation), stack)
       == Execute(continuation, [Eval(expr)] + stack)
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):
        Show that the compiled Push instruction places value on the stack
        before executing continuation.

      First inductive case,
      Q(left) ∧ Q(right) ⇒ Q(Add(left, right)):
        Apply Q(left) with
          Compile(right, AddValues(continuation))
        as its continuation. Then apply Q(right) with
          AddValues(continuation)
        as its continuation and [Eval(left)] + stack as its initial stack.
        The AddValues instruction combines the resulting operand values.

      Second inductive case,
      Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):
        Use the analogous argument with MultiplyValues.

    In the two operator cases, it may be useful to rewrite the stack

      [Eval(right)] + ([Eval(left)] + stack)

    as the equivalent sequence

      [Eval(right), Eval(left)] + stack

    before unfolding Execute on AddValues or MultiplyValues.
  */
}

//========================================================================
// Derives correctness for a complete compiled expression. Execution
// succeeds and leaves exactly the value of the expression on the stack.
lemma CompilerCorrect(expr:Expr)
  ensures Run(expr) == Success([Eval(expr)])
{
  /*
    Apply CompileCorrect with continuation = Done and stack = [].
  */
}
