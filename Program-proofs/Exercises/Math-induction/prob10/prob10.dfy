/*  file: prob10.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob10
*/

//========================================================================
// Proves by induction on n that the product of two consecutive natural
// numbers is divisible by 2.
lemma {:induction false} TwoConsecutiveDivisibleByTwo(n:nat)
  ensures exists k:int :: n * (n+1) == 2*k
  decreases n
{
  /*
    Prove this lemma by mathematical induction on n.

    Hint:
      The induction hypothesis gives an existential statement. To use its
      witness in the induction step, you may need Dafny's assign-such-that
      operator:

        var k:int :| P(k);

      This means: choose an integer k such that P(k) holds.
  */
}