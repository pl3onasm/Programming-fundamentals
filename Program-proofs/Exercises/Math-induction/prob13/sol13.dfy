/*  file: sol13.dfy
    author: David De Potter
    description: proof by induction that n! is bounded below by 2^(n-1)
*/

//========================================================================
// Recursively defines n factorial.
ghost function Factorial(n:nat): nat
  decreases n
{
  if n == 0 then 1
            else n * Factorial(n-1)
}

//========================================================================
// Recursively defines 2 to the power of n.
ghost function Pow2(n:nat): nat
  decreases n
{
  if n == 0 then 1
            else 2 * Pow2(n-1)
}

//========================================================================
// Proves by induction on n that n! ≥ 2^(n-1), for every n ≥ 1.
lemma {:induction false} FactorialLowerBound(n:nat)
  requires 1 <= n
  ensures  Factorial(n) >= Pow2(n-1)
  decreases n
{
  if n == 1
  {
      // Base case: Q(1) is true
    assert Factorial(1) >= Pow2(0) by
    {
      calc
      {
        Factorial(1);
          // Unfold Factorial(1)
        == 1;
          // Arithmetic
        >= 1;
          // Fold Pow2(0)
        == Pow2(0);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   (n-1)! ≥ 2^(n-2)
    FactorialLowerBound(n-1);

      // Since n > 1, we have n ≥ 2
    assert n >= 2;

      // Induction step
      // Prove Q(n) is true
    calc
    {
      Factorial(n);
        // Unfold Factorial(n)
      == n * Factorial(n-1);
        // Since n ≥ 2 and Factorial(n-1) is nonnegative
      >= 2 * Factorial(n-1);
        // Apply the induction hypothesis
      >= 2 * Pow2(n-2);
        // Rewrite 2 * Pow2(n-2) as Pow2(n-1)
      == Pow2(n-1);
    }
  }
}