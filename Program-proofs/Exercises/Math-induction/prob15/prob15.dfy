/*  file: prob15.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob15
*/

//========================================================================
// Proves by induction on n that every third Fibonacci number is even:
//   Fib(3n) is divisible by 2.
lemma {:induction false} EveryThirdFibEven(n:nat)
  ensures exists k:int :: Fib(3*n) == 2*k
  decreases n
{
  /*
    First define the recursive function Fib.

    Then prove this lemma by mathematical induction on n.

    You may find it useful to prove the following three-step Fibonacci
    identity as a separate helper lemma:

      Fib(n+3) = 2*Fib(n+1) + Fib(n)
  */
}