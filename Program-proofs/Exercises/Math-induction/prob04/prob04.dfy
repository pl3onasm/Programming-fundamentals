/*  file: prob04.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob04
*/

//========================================================================
// Recursively defines the sum of the squares of the first n odd integers:
//   SumOddSquares(n) = ∑((2*i - 1)² | i: 1 ≤ i ≤ n)
ghost function SumOddSquares(n:nat): nat
  decreases n
{
  // Define this recursive function yourself.
}

//========================================================================
// Proves the following formula for the sum of the squares of the first n
// odd integers by induction on n:
//    ∑((2*i - 1)² | i: 1 ≤ i ≤ n) = n(2n-1)(2n+1)/3
lemma {:induction false} SumOddSquaresFormula(n:nat)
  ensures 3 * SumOddSquares(n) == n * (2*n - 1) * (2*n + 1)
  decreases n
{
  /*
    Prove this lemma by mathematical induction on n.

      Base case, Q(0):
        Show that the formula is true for n = 0

      Induction step, Q(n-1) ⇒ Q(n):
        Assume the formula is true for n-1, and show that it is true for n

    The postcondition is written without division to avoid integer-
    division side conditions. It is equivalent to the usual identity

      ∑((2*i - 1)² | i: 1 ≤ i ≤ n) = n(2n-1)(2n+1) / 3
  */
}