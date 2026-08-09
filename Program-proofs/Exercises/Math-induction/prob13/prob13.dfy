/*  file: prob13.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob13
*/

//========================================================================
// Proves by induction on n that n! ≥ 2^(n-1), for every n ≥ 1.
lemma {:induction false} FactorialLowerBound(n:nat)
  requires n > 0
  ensures  Factorial(n) >= Pow2(n-1)
  decreases n
{
  /*
    First define recursive functions Factorial and Pow2.

    Then prove this lemma by mathematical induction on n.

  */
}