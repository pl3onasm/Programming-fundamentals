/*  file: prob11.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob11
*/

include "../prob10/sol10.dfy"

//========================================================================
// Proves by induction on n that the product of three consecutive natural
// numbers is divisible by 6.
lemma {:induction false} ThreeConsecutiveDivisibleBySix(n:nat)
  ensures exists k:int :: n * (n+1) * (n+2) == 6*k
  decreases n
{
  /*
    Prove this lemma by mathematical induction on n.

    Hint:
      You may use the previously proved lemma from exercise 10:

        TwoConsecutiveDivisibleByTwo(n)

      To make this lemma available, the file sol10.dfy is included 
      at the top of this file. The lemma states that n * (n+1) is 
      divisible by 2.
  */
}