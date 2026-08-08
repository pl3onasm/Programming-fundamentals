/*  file: prob06.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob06
*/

//========================================================================
// Proves the following inequality by induction on n:
//   1 + 2^n < 3^n, for n ≥ 2
lemma {:induction false} PowersInequality(n:nat)
  requires n >= 2
  ensures  1 + Pow2(n) < Pow3(n)
  decreases n
{
  /*
    First define recursive functions Pow2 and Pow3 for powers of 2 and 3.

    Then prove this lemma by mathematical induction on n.

      Base case, Q(2):
        Show that 1 + 2² < 3²

      Induction step, Q(n-1) ⇒ Q(n):
        Assume 1 + 2^(n-1) < 3^(n-1), and prove 1 + 2^n < 3^n
  */
}