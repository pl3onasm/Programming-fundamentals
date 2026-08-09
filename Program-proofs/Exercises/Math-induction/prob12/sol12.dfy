/*  file: sol12.dfy
    author: David De Potter
    description: proof by induction of a factorial weighted-sum formula
*/

//========================================================================
// Recursively defines n factorial.
ghost function Factorial(n:nat): int
  decreases n
{
  if n == 0 then 1
            else n * Factorial(n-1)
}

//========================================================================
// Recursively defines the weighted sum of factorials:
//   WeightedSum(n) = ∑(i * i! | i: 1 ≤ i ≤ n)
ghost function WeightedSum(n:nat): int
  decreases n
{
  if n == 0 then 0
            else WeightedSum(n-1) + n * Factorial(n)
}

//========================================================================
// Proves by induction on n that:
//   ∑(i * i! | i: 1 ≤ i ≤ n) = (n+1)! - 1, for n ≥ 1
lemma {:induction false} WeightedSumFormula(n:nat)
  requires n > 0
  ensures  WeightedSum(n) == Factorial(n+1) - 1
  decreases n
{
  if n == 1
  {
      // Base case: Q(1) is true
    assert WeightedSum(1) == Factorial(2) - 1 by
    {
      calc
      {
        WeightedSum(1);
          // Unfold WeightedSum(1)
        == 1 * Factorial(1);
          // Unfold Factorial(1)
        == 1 * 1;
          // Arithmetic
        == 1;
          // Arithmetic
        == 2 - 1;
          // Fold Factorial(2)
        == Factorial(2) - 1;
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   WeightedSum(n-1) = Factorial(n) - 1
    WeightedSumFormula(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      WeightedSum(n);
        // Unfold WeightedSum(n)
      == WeightedSum(n-1) + n * Factorial(n);
        // Apply the induction hypothesis
      == Factorial(n) - 1 + n * Factorial(n);
        // Factor out Factorial(n)
      == (n+1) * Factorial(n) - 1;
        // Rewrite (n+1) * Factorial(n) as Factorial(n+1)
      == Factorial(n+1) - 1;
    }
  }
}