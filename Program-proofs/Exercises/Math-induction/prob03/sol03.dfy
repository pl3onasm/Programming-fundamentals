/*  file: sol03.dfy
    author: David De Potter
    description: proof by induction of the formula for the sum of
    powers of two
*/

//========================================================================
// Recursively defines 2^n.
// The base case is 2^0 = 1. For n > 0, one additional factor 2 is
// multiplied onto 2^(n-1).
ghost function Pow2(n:nat): int
  decreases n
{
  if n == 0 then 1
            else 2 * Pow2(n-1)
}

//========================================================================
// Recursively defines the sum of powers of two up to 2^n:
//   SumPowers(n) = ∑(2^i | i: 0 ≤ i ≤ n)
ghost function SumPowers(n:nat): int
  decreases n
{
  if n == 0 then 1
            else SumPowers(n-1) + Pow2(n)
}

//========================================================================
// Proves the following formula for the sum of powers of two by induction
// on n:  ∑(2^i | i: 0 ≤ i ≤ n) = 2^(n+1) - 1
lemma {:induction false} SumPowersFormula(n:nat)
  ensures SumPowers(n) == Pow2(n+1) - 1
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true
    assert SumPowers(0) == Pow2(0+1) - 1 by
    {
      calc
      {
        SumPowers(0);
          // Unfold SumPowers(0)
        == 1;
          // Arithmetic
        == 2 - 1;
          // Fold Pow2(1)
        == Pow2(1) - 1;
          // Arithmetic
        == Pow2(0+1) - 1;
      }
    }
  }
  
  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   SumPowers(n-1) = Pow2(n) - 1
    SumPowersFormula(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      SumPowers(n);
        // Unfold SumPowers(n)
      == SumPowers(n-1) + Pow2(n);
        // Apply the induction hypothesis
      == Pow2(n) - 1 + Pow2(n);
        // Combine the two copies of Pow2(n)
      == 2 * Pow2(n) - 1;
        // Rewrite 2 * Pow2(n) as Pow2(n+1)
      == Pow2(n+1) - 1;
    }
  }

}