/*  file: prob08.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob08
*/

//========================================================================
// Proves by induction on n that 3 divides n³ - n, for every positive
// integer n.
lemma {:induction false} DivisibleByThree(n:nat)
  requires 1 <= n
  ensures  exists k:int :: n*n*n - n == 3*k
  decreases n
{
  /*
    Prove this lemma by mathematical induction on n.

      Base case, Q(1):
        Show that 3 divides 1³ - 1

      Induction step, Q(n-1) ⇒ Q(n):
        Assume 3 divides (n-1)³ - (n-1), and prove that
        3 divides n³ - n

    Hint:
      The induction hypothesis gives an existential statement. To use its
      witness in the induction step, you may need Dafny's assign-such-that
      operator:

        var k:int :| P(k);

      This means: choose an integer k such that P(k) holds.
  */
}