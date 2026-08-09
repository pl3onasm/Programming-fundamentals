/*  file: prob14.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob14
*/

//========================================================================
// Proves by induction on n that the sum of the first n+1 Fibonacci
// squares is F(n)F(n+1):
//   ∑(Fib(i)² | i: 0 ≤ i ≤ n) = Fib(n) * Fib(n+1)
lemma {:induction false} FibonacciSquaresFormula(n:nat)
  ensures FibSquaresSum(n) == Fib(n) * Fib(n+1)
  decreases n
{
  /*
    First define recursive functions Fib and FibSquaresSum.

    Then prove this lemma by mathematical induction on n.

  */
}