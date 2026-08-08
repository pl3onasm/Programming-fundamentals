/*  file: sol04.dfy
    author: David De Potter
    description: proof by induction of the formula for the sum of the
    squares of the first n odd integers
*/

//========================================================================
// Recursively defines the sum of the squares of the first n odd integers:
//   SumOddSquares(n) = ∑((2*i - 1)² | i: 1 ≤ i ≤ n)
ghost function SumOddSquares(n:nat): nat
  decreases n
{
  if n == 0 then 0
            else SumOddSquares(n-1) + (2*n - 1) * (2*n - 1)
}

//========================================================================
// Proves the following formula for the sum of the squares of the first n
// odd integers by induction on n:
//   ∑((2*i - 1)² | i: 1 ≤ i ≤ n) = n(2n-1)(2n+1)/3
lemma {:induction false} SumOddSquaresFormula(n:nat)
  ensures 3 * SumOddSquares(n) == n * (2*n - 1) * (2*n + 1)
  decreases n
{
  if n == 0
    {
      // Base case: Q(0) is true
    assert 3 * SumOddSquares(0) == 0 * (2*0 - 1) * (2*0 + 1);
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   3 * SumOddSquares(n-1) = (n-1) * (2*(n-1) - 1) * (2*(n-1) + 1)
    SumOddSquaresFormula(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      3 * SumOddSquares(n);
        // Unfold SumOddSquares(n)
      == 3 * (SumOddSquares(n-1) + (2*n - 1) * (2*n - 1));
        // Distribute 3 over the sum
      == 3 * SumOddSquares(n-1) + 3 * (2*n - 1) * (2*n - 1);
        // Apply the induction hypothesis
      == (n-1) * (2*(n-1) - 1) * (2*(n-1) + 1) 
         + 3 * (2*n - 1) * (2*n - 1);
        // Simplify the factors containing n-1
      == (n-1) * (2*n - 3) * (2*n - 1) + 3 * (2*n - 1) * (2*n - 1);
        // Factor out the common term 2*n - 1
      == (2*n - 1) * ((n-1) * (2*n - 3) + 3 * (2*n - 1));
        // Expand and combine like terms inside the parentheses
      == (2*n - 1) * (2*n*n + n);
        // Factor out n
      == (2*n - 1) * n * (2*n + 1);
        // Reorder the factors
      == n * (2*n - 1) * (2*n + 1);
    }
  }

}