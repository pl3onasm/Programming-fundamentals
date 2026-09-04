/*  file: prob35.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob35
    
    NOTE:
    This final exercise verifies a small compiler for arithmetic
    expression trees. The compiler translates an expression into code
    whose execution produces the same result as evaluating the expression
    directly.

    The generated code is executed by a stack machine. A stack machine is
    a simple abstract computer that stores intermediate values on a stack
    instead of in named variables or registers. A stack is a last-in,
    first-out structure: instructions add values to its top and retrieve
    operands from its top. In this exercise, Push places a value on the
    stack, while AddValues and MulValues remove the top two values
    and replace them with their sum or product.

    The compiler arranges these instructions so that they preserve the
    evaluation order of the expression tree. A Const expression becomes
    a Push instruction. An Add or Mul expression first executes the code
    for its left operand, then the code for its right operand, and finally
    an instruction that combines the two resulting stack values.

    Code is represented as a linked chain of instructions. Every 
    instruction except Done contains the code that must be executed next. 
    The compiler receives this remaining code as a continuation. It wraps 
    each new instruction directly around the code that follows it, which 
    is efficient because this way it never has to traverse an already 
    constructed instruction chain to append more instructions at its end.

    The property that we ultimately want for a complete program is:

      Run(expr) = Success([Eval(expr)])

    In other words, compiling and executing expr from an empty stack must
    succeed and leave only the mathematical value of the original 
    expression on the stack. This statement, however, is too specific to 
    serve as the induction hypothesis in a structural induction proof.

    If we attempted to prove the above property by structural induction, 
    the induction hypotheses for the two subexpressions would be:

      Run(left)  = Success([Eval(left)])
      Run(right) = Success([Eval(right)])

    After unfolding Run and CompileExpression, these hypotheses become:

      Execute(Compile(left,  Done), []) = Success([Eval(left)])

      Execute(Compile(right, Done), []) = Success([Eval(right)])

    These statements apply only when the subexpression is compiled as a
    complete program, with Done as its continuation, and executed from an
    empty stack. However, these are not the circumstances in which left 
    and right are evaluated while executing the compiled code for an 
    expression such as Add(left, right).

    For the recursive call on left, we instead need to show:

      Execute(Compile(left, Compile(right, AddValues(Done))), [])
      = Execute(Compile(right, AddValues(Done)), [Eval(left)])

    The continuation is now the code that evaluates right and then adds 
    the two values. For the recursive call on right, we need:

      Execute(Compile(right, AddValues(Done)), [Eval(left)])
      = Execute(AddValues(Done), [Eval(right), Eval(left)])

    This execution begins with Eval(left) already on the stack and uses
    AddValues(Done) as its continuation. Neither statement follows from 
    the direct induction hypotheses, because those hypotheses fix the
    continuation to Done and the initial stack to []. The direct property 
    is therefore too specific to handle the recursive compiler calls.

    We need an induction hypothesis that allows both the continuation and
    the initial stack to vary. We therefore prove the more general 
    property:

      Execute(Compile(expr, continuation), stack)
      = Execute(continuation, [Eval(expr)] + stack)

    This property states that, for any continuation and any initial stack,
    executing the compiled code for expr has the same effect as placing
    Eval(expr) on top of that stack and then executing the continuation.

    In the Add case, this property can first be applied to left with the
    code for right as its continuation. It can then be applied to right
    with Eval(left) already on the stack. The Mul case works in the same
    way. Finally, choosing continuation = Done and stack = [] gives the
    desired correctness result for a complete program.

    For a complete example showing how an expression is compiled and how
    the resulting instructions manipulate the stack, see 
    compilerExample.md.
*/

include "../../Support/Datatypes/Finite/ExpressionTrees.dfy"
import opened ExpressionTrees

//========================================================================
// Represents code for a stack machine. Done ends execution. Push places
// a value on the stack. AddValues and MulValues remove the top two
// values, combine them, and push the result. Every instruction except
// Done contains the code that is executed next.
datatype Code = Done
              | Push(value:int, next:Code)
              | AddValues(next:Code)
              | MulValues(next:Code)

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
  case MulValues(next) =>
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
    Compile(left, Compile(right, MulValues(continuation)))
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
// Proves that executing the code for expr in front of an arbitrary 
// continuation has the same effect as pushing Eval(expr) onto the initial 
// stack and then executing that continuation.
lemma {:induction false} CompileCorrect(expr:Expr, cont:Code, 
                                        stack:seq<int>)
  ensures Execute(Compile(expr, cont), stack)
       == Execute(cont, [Eval(expr)] + stack)
  decreases expr
{
  /*
    Prove this lemma by structural induction on expr.

      Base case, Q(Const(value)):

        Show that the compiled Push instruction places value on the stack
        before executing continuation.

      First inductive case, Q(left) ∧ Q(right) ⇒ Q(Add(left, right)):

        Apply Q(left) with Compile(right, AddValues(cont)) as its 
        continuation. Then apply Q(right) with AddValues(cont) as its 
        continuation and [Eval(left)] + stack as its initial stack.
        The AddValues instruction combines the two resulting operand 
        values.

      Second inductive case, Q(left) ∧ Q(right) ⇒ Q(Mul(left, right)):
        
        Use the analogous argument for MulValues.
  */
}

//========================================================================
// Proves correctness for a complete compiled expression. Execution
// succeeds and leaves exactly the value of the expression on the stack.
lemma RunCorrect(expr:Expr)
  ensures Run(expr) == Success([Eval(expr)])
{
  //  Apply CompileCorrect with continuation = Done and stack = []
}