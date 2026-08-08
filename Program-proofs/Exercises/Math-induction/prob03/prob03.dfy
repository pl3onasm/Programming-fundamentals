/*  file: prob03.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob03
*/

//========================================================================
// Recursively defines 2^n.
ghost function Pow2(n:nat): int
  decreases n
{
  // Define this recursive function yourself.
}

//========================================================================
// Recursively defines the sum of powers of two up to 2^n:
//   SumPowers(n) = ∑(2^i | i: 0 ≤ i ≤ n)
ghost function SumPowers(n:nat): int
  decreases n
{
  // Define this recursive function yourself.
}

//========================================================================
// Proves the following formula for the sum of powers of two by induction
// on n:  ∑(2^i | i: 0 ≤ i ≤ n) = 2^(n+1) - 1
lemma {:induction false} SumPowersFormula(n:nat)
  ensures SumPowers(n) == Pow2(n+1) - 1
  decreases n
{
  /*
    Prove this lemma by mathematical induction on n.

      Base case, Q(0):
        Show that SumPowers(0) = 2^(0+1) - 1

      Induction step, Q(n-1) ⇒ Q(n):
        Assume the formula is true for n-1, and show that it is true for n
  */
}