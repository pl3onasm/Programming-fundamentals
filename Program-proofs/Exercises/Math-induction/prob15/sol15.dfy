/*  file: sol15.dfy
    author: David De Potter
    description: proof by induction that every third Fibonacci number
    is even
*/

//========================================================================
// Recursively defines the Fibonacci numbers:
//   Fib(0) = 0
//   Fib(1) = 1
//   Fib(n) = Fib(n-1) + Fib(n-2), for n ≥ 2
ghost function Fib(n:nat): nat
  decreases n
{
  if n == 0 then 0
  else if n == 1 then 1
  else Fib(n-1) + Fib(n-2)
}

//========================================================================
// Proves the three-step Fibonacci identity:
//   Fib(n+3) = 2*Fib(n+1) + Fib(n)
//
// This identity is used in the main proof to move from Fib(3(n-1)) to
// Fib(3n).
lemma FibStep3(n:nat)
  ensures Fib(n+3) == 2*Fib(n+1) + Fib(n)
{
    // Dafny proves this lemma automatically by unfolding the recursive
    // definition of Fib at n+3, n+2, and n+1.
}

//========================================================================
// Proves by induction on n that every third Fibonacci number is even:
//   Fib(3n) is divisible by 2.
lemma {:induction false} EveryThirdFibEven(n:nat)
  ensures exists k:int :: Fib(3*n) == 2*k
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true. The value 0 is a witness
      // because Fib(0) = 0 = 2 * 0.
    assert exists k:int :: Fib(3*n) == 2*k by
    {
      var k0:int := 0;

      calc
      {
        Fib(3*n);
          // Since n = 0
        == Fib(0);
          // Unfold Fib(0)
        == 0;
          // Arithmetic
        == 2*k0;
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   there exists some k such that Fib(3(n-1)) = 2*k
    EveryThirdFibEven(n-1);

      // The induction hypothesis gives an existential statement.
      // We use Dafny's assign-such-that operator :| to choose a witness
      // k from the induction hypothesis, so that we can use it in the
      // induction step. The witness k is an integer such that:
      //   Fib(3(n-1)) = 2*k
    var k:int :| Fib(3*(n-1)) == 2*k;

      // Use the three-step Fibonacci identity with index 3(n-1)
    FibStep3(3*(n-1));

      // Induction step
      // Prove Q(n) is true
    calc
    {
      Fib(3*n);
        // Rewrite 3n as 3(n-1)+3
      == Fib(3*(n-1) + 3);
        // Apply FibStep3
      == 2*Fib(3*(n-1) + 1) + Fib(3*(n-1));
        // Apply the induction hypothesis
      == 2*Fib(3*(n-1) + 1) + 2*k;
        // Factor out 2
      == 2 * (Fib(3*(n-1) + 1) + k);
    }

      // The calculation shows that Fib(3*(n-1) + 1) + k
      // is a witness for Q(n)
    assert exists q:int :: Fib(3*n) == 2*q by
    {
      var q0:int := Fib(3*(n-1) + 1) + k;
      assert Fib(3*n) == 2*q0;
    }
  }
}