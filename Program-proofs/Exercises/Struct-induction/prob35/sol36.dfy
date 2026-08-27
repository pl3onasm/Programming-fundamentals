/*  file: sol36.dfy
    author: David De Potter
    description: proof by structural induction of the correctness of a
      stack-machine compiler for arithmetic expression trees
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
// Proves by structural induction on expr that executing its compiled code
// in front of an arbitrary continuation has the same effect as pushing
// Eval(expr) onto the initial stack and executing that continuation.
lemma {:induction false} CompileCorrect(
  expr:Expr, continuation:Code, stack:seq<int>)
  ensures Execute(Compile(expr, continuation), stack)
       == Execute(continuation, [Eval(expr)] + stack)
  decreases expr
{
  match expr
  case Const(value) =>
      // Base case: Q(Const(value)) is true
    calc
    {
      Execute(Compile(expr, continuation), stack);
        // Replace expr by Const(value)
      == Execute(Compile(Const(value), continuation), stack);
        // Unfold Compile
      == Execute(Push(value, continuation), stack);
        // Execute Push by placing value on top of the stack
      == Execute(continuation, [value] + stack);
        // Rewrite value as Eval(Const(value))
      == Execute(continuation, [Eval(Const(value))] + stack);
        // Replace Const(value) by expr
      == Execute(continuation, [Eval(expr)] + stack);
    }

  case Add(left, right) =>
      // First induction hypothesis
      // Compile and execute left before the code for right
    CompileCorrect(
      left, Compile(right, AddValues(continuation)), stack);

      // Second induction hypothesis
      // Compile and execute right after Eval(left) has been pushed
    CompileCorrect(
      right, AddValues(continuation), [Eval(left)] + stack);

      // Rewrite the two values pushed by the compiled operands as a
      // single two-element prefix of the original stack.
    assert [Eval(right)] + ([Eval(left)] + stack)
        == [Eval(right), Eval(left)] + stack;

      // First inductive case
      // Prove Q(Add(left, right)) is true
    calc
    {
      Execute(Compile(expr, continuation), stack);
        // Replace expr by Add(left, right)
      == Execute(Compile(Add(left, right), continuation), stack);
        // Unfold Compile
      == Execute(
           Compile(left, Compile(right, AddValues(continuation))),
           stack);
        // Apply the induction hypothesis for left
      == Execute(
           Compile(right, AddValues(continuation)),
           [Eval(left)] + stack);
        // Apply the induction hypothesis for right
      == Execute(
           AddValues(continuation),
           [Eval(right)] + ([Eval(left)] + stack));
        // Combine the two singleton prefixes into one two-value prefix
      == Execute(
           AddValues(continuation),
           [Eval(right), Eval(left)] + stack);
        // AddValues combines the two operand values on the stack
      == Execute(
           continuation,
           [Eval(left) + Eval(right)] + stack);
        // Rewrite the sum as Eval(Add(left, right))
      == Execute(
           continuation,
           [Eval(Add(left, right))] + stack);
        // Replace Add(left, right) by expr
      == Execute(continuation, [Eval(expr)] + stack);
    }

  case Mul(left, right) =>
      // First induction hypothesis
      // Compile and execute left before the code for right
    CompileCorrect(
      left, Compile(right, MultiplyValues(continuation)), stack);

      // Second induction hypothesis
      // Compile and execute right after Eval(left) has been pushed
    CompileCorrect(
      right, MultiplyValues(continuation), [Eval(left)] + stack);

      // Rewrite the two values pushed by the compiled operands as a
      // single two-element prefix of the original stack.
    assert [Eval(right)] + ([Eval(left)] + stack)
        == [Eval(right), Eval(left)] + stack;

      // Second inductive case
      // Prove Q(Mul(left, right)) is true
    calc
    {
      Execute(Compile(expr, continuation), stack);
        // Replace expr by Mul(left, right)
      == Execute(Compile(Mul(left, right), continuation), stack);
        // Unfold Compile
      == Execute(
           Compile(left, Compile(right, MultiplyValues(continuation))),
           stack);
        // Apply the induction hypothesis for left
      == Execute(
           Compile(right, MultiplyValues(continuation)),
           [Eval(left)] + stack);
        // Apply the induction hypothesis for right
      == Execute(
           MultiplyValues(continuation),
           [Eval(right)] + ([Eval(left)] + stack));
        // Combine the two singleton prefixes into one two-value prefix
      == Execute(
           MultiplyValues(continuation),
           [Eval(right), Eval(left)] + stack);
        // MultiplyValues combines the two operand values on the stack
      == Execute(
           continuation,
           [Eval(left) * Eval(right)] + stack);
        // Rewrite the product as Eval(Mul(left, right))
      == Execute(
           continuation,
           [Eval(Mul(left, right))] + stack);
        // Replace Mul(left, right) by expr
      == Execute(continuation, [Eval(expr)] + stack);
    }
}

//========================================================================
// Derives correctness for a complete compiled expression. Execution
// succeeds and leaves exactly the value of the expression on the stack.
lemma CompilerCorrect(expr:Expr)
  ensures Run(expr) == Success([Eval(expr)])
{
    // Apply the strengthened correctness property with no continuation
    // and an initially empty stack.
  CompileCorrect(expr, Done, []);

  calc
  {
    Run(expr);
      // Unfold Run
    == Execute(CompileExpression(expr), []);
      // Unfold CompileExpression
    == Execute(Compile(expr, Done), []);
      // Apply CompileCorrect
    == Execute(Done, [Eval(expr)]);
      // Executing Done returns the current stack
    == Success([Eval(expr)]);
  }
}
