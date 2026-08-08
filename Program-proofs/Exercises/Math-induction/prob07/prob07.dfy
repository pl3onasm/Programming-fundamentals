/*  file: prob07.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob07
*/

//========================================================================
// Proves the following inequality by induction on n:
//   1 + 2 + 3 + ... + n < (2n+1)² / 8
lemma {:induction false} SumBound(n:nat)
  ensures 8 * Sum(n) < (2*n + 1) * (2*n + 1)
  decreases n
{
  /*
    First define a recursive function Sum for the sum of the first n
    positive integers.

    Then prove the equivalent division-free form by induction on n:

      8 * Sum(n) < (2n+1)²

    This is equivalent to the original inequality

      1 + 2 + 3 + ... + n < (2n+1)² / 8


    Base case, Q(0):
      Show that the formula is true for n = 0

    Induction step, Q(n-1) ⇒ Q(n):
      Assume 8 * Sum(n-1) < (2(n-1)+1)², and prove
      8 * Sum(n) < (2n+1)²
  */
}