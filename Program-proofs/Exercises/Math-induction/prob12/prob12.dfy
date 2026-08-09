/*  file: prob12.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob12
*/

//========================================================================
// Proves by induction on n that:
//   ∑(i * i! | i: 1 ≤ i ≤ n) = (n+1)! - 1, for n ≥ 1
lemma {:induction false} WeightedSumFormula(n:nat)
  requires n > 0
  ensures  WeightedSum(n) == Factorial(n+1) - 1
  decreases n
{
  /*
    First define recursive functions Factorial and WeightedSum.

    Then prove this lemma by mathematical induction on n.

  */
}