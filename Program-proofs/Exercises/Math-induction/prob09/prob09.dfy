/*  file: prob09.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob09
*/

//========================================================================
// Proves by induction on n that 2 divides n² - n.
lemma {:induction false} DivisibleByTwo(n:nat)
  ensures exists k:int :: n*n - n == 2*k
  decreases n
{
  /*
    Prove this lemma by mathematical induction on n.

      Base case, Q(0):
        Show that 2 divides 0² - 0

      Induction step, Q(n-1) ⇒ Q(n):
        Assume 2 divides (n-1)² - (n-1), and prove that
        2 divides n² - n

    Hint:
      The induction hypothesis gives an existential statement. To use its
      witness in the induction step, you may need Dafny's assign-such-that
      operator:

        var k:int :| P(k);

      This means: choose an integer k such that P(k) holds.
  */
}