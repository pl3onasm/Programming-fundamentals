/*  file: sol14.dfy
    author: David De Potter
    description: proof by induction of the Fibonacci squares identity
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
// Recursively defines the sum of the first n+1 Fibonacci squares:
//   FibSquaresSum(n) = ∑(Fib(i)² | i: 0 ≤ i ≤ n)
ghost function FibSquaresSum(n:nat): nat
  decreases n
{
  if n == 0 then Fib(0) * Fib(0)
            else FibSquaresSum(n-1) + Fib(n) * Fib(n)
}

//========================================================================
// Proves by induction on n that the sum of the first n+1 Fibonacci
// squares is F(n) * F(n+1): ∑(Fib(i)² | i: 0 ≤ i ≤ n) = Fib(n) * Fib(n+1)
lemma {:induction false} FibonacciSquaresFormula(n:nat)
  ensures FibSquaresSum(n) == Fib(n) * Fib(n+1)
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true
    assert FibSquaresSum(0) == Fib(0) * Fib(1) by
    {
      calc
      {
        FibSquaresSum(0);
          // Unfold FibSquaresSum(0)
        == Fib(0) * Fib(0);
          // Unfold Fib(0)
        == 0;
          // Arithmetic
        == 0 * 1;
          // Fold Fib(0) and Fib(1)
        == Fib(0) * Fib(1);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   FibSquaresSum(n-1) = Fib(n-1) * Fib(n)
    FibonacciSquaresFormula(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      FibSquaresSum(n);
        // Unfold FibSquaresSum(n)
      == FibSquaresSum(n-1) + Fib(n) * Fib(n);
        // Apply the induction hypothesis
      == Fib(n-1) * Fib(n) + Fib(n) * Fib(n);
        // Factor out Fib(n)
      == Fib(n) * (Fib(n-1) + Fib(n));
        // Fold Fib(n+1)
      == Fib(n) * Fib(n+1);
    }
  }
}