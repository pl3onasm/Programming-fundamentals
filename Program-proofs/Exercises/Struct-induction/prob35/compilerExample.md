# Worked Example: Compiling and Executing an Expression Tree

This example illustrates how the compiler in `prob35.dfy` translates an arithmetic expression tree into stack-machine code and how the generated instructions are then executed.
  
## Expression and Tree

Consider the expression

```text
5 + ((4 * 2) + (3 * (2 + 1)))
```

Its expression tree is:

```text
          Add
         /   \
        5     Add
             /   \
           Mul    Mul
          /  \    /  \
         4    2  3    Add
                     /   \
                    2     1
```

Each number in the diagram represents a `Const` node. The corresponding expression tree in Dafny syntax is:

```dafny
Add(
  Const(5),
  Add(
    Mul(Const(4), Const(2)),
    Mul(Const(3), Add(Const(2), Const(1)))
  )
)
```

Direct evaluation of the expression gives:

```text
5 + ((4 * 2) + (3 * (2 + 1)))
= 5 + (8 + 9)
= 22
```

The compiled program must therefore finish with `22` as the only value on the stack.

## The Stack Machine

A stack machine stores intermediate values on a stack instead of in named variables or registers. The stack is a last-in, first-out structure (LIFO): the most recently added value is the first value used by the next operation.

In this example, the leftmost sequence element is the top of the stack. The instructions behave as follows:

- `Push(value, next)` places `value` on top of the stack and executes `next`.
- `AddValues(next)` removes the top two values, pushes their sum, and executes `next`.
- `MulValues(next)` removes the top two values, pushes their product, and executes `next`.
- `Done` ends execution and returns the current stack.

Every instruction except `Done` stores the code to be executed afterward in its `next` field. This remaining code is the continuation of the current instruction.

## Compilation

For readability, we give the subexpressions the following names:

```text
m1   = Mul(Const(4), Const(2))
a1   = Add(Const(2), Const(1))
m2   = Mul(Const(3), a1)
a2   = Add(m1, m2)
expr = Add(Const(5), a2)
```

Compilation begins with `Done`, because no code must run after the complete expression has been evaluated:

```text
Compile(expr, Done)
```

Unfolding `Compile` for the outer `Add` gives:

```text
Compile(Const(5), Compile(a2, AddValues(Done)))

= Push(5, Compile(a2, AddValues(Done)))
```

The code for `Const(5)` does not end in `Done`. Its continuation evaluates `a2` and then adds the two resulting values. Consequently, the value `5` remains on the stack while the right subtree is evaluated.

Expanding the `Add` represented by `a2` gives:

```text
Push(5,
  Compile(
    m1,
    Compile(m2, AddValues(AddValues(Done)))
  )
)
```

The inner `AddValues` combines the values of `m1` and `m2`. The outer `AddValues` subsequently combines that result with `5`.

Expanding `m1` gives:

```text
Push(5,
  Push(4,
    Push(2,
      MulValues(
        Compile(m2, AddValues(AddValues(Done)))
      )
    )
  )
)
```

The multiplication stored in `m2` first pushes `3` and then evaluates `a1`. The addition stored in `a1` pushes `2` and `1` before applying `AddValues`. After all calls to `Compile` have been expanded, reading the resulting nested `Code` value from its outermost instruction inward gives the following execution order:

```text
Push(5)
  -> Push(4)
  -> Push(2)
  -> MulValues
  -> Push(3)
  -> Push(2)
  -> Push(1)
  -> AddValues
  -> MulValues
  -> AddValues
  -> AddValues
  -> Done
```

Each arrow represents the transition from an instruction to the continuation stored in its `next` field.

## Execution

Execution begins with the empty stack `[]`. The leftmost value shown in the table is the top of the stack.

| Instruction | Stack after instruction | Operation performed |
|:--|:--|:--|
| Initial state | `[]` | No instruction has run yet |
| `Push(5)` | `[5]` | Push `5` |
| `Push(4)` | `[4, 5]` | Push `4` |
| `Push(2)` | `[2, 4, 5]` | Push `2` |
| `MulValues` | `[8, 5]` | Replace `4` and `2` by `4 * 2 = 8` |
| `Push(3)` | `[3, 8, 5]` | Push `3` |
| `Push(2)` | `[2, 3, 8, 5]` | Push `2` |
| `Push(1)` | `[1, 2, 3, 8, 5]` | Push `1` |
| `AddValues` | `[3, 3, 8, 5]` | Replace `2` and `1` by `2 + 1 = 3` |
| `MulValues` | `[9, 8, 5]` | Replace `3` and `3` by `3 * 3 = 9` |
| `AddValues` | `[17, 5]` | Replace `8` and `9` by `8 + 9 = 17` |
| `AddValues` | `[22]` | Replace `5` and `17` by `5 + 17 = 22` |
| `Done` | `[22]` | Return `Success([22])` |

Thus, running the compiled expression produces:

```text
Run(expr) = Success([22]) = Success([Eval(expr)])
```

## Connection to the Proof

The example also shows why compiler correctness is first proved for an arbitrary continuation and an arbitrary initial stack. When compiling the outer `Add`, the recursive call for `Const(5)` uses `Compile(a2, AddValues(Done))` as its continuation. The recursive compilation of `a2` then begins with `5` already on the stack. The intermediate recursive calls therefore do not describe complete programs that end immediately or executions that always begin with an empty stack.

The generalized correctness property handles precisely these situations:

```text
Execute(Compile(expr, continuation), stack)
= Execute(continuation, [Eval(expr)] + stack)
```

It says that the compiled code evaluates `expr`, places its value on top of whatever stack was already present, and then runs whatever continuation was still waiting. The correctness result for a complete program then follows by choosing `continuation = Done` and `stack = []`.
