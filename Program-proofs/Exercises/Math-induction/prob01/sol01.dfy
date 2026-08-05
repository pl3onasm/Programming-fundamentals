/*  file: sol01.dfy
    author: David De Potter
    description: proof by induction of the formula for the sum of the
    first n squares
*/

//========================================================================
// Recursively defines the sum of the first n squares:
//   SumSquares(n) = ∑(i² | i: 1 ≤ i ≤ n)
// The empty sum is 0, so SumSquares(0) = 0. For n > 0, the final
// square n² is added to the sum of the first n-1 squares.
ghost function SumSquares(n:nat): nat
  decreases n
{
  if n == 0 then 0
            else SumSquares(n-1) + n*n
}

//========================================================================
// Proves the following formula for the sum of the first n squares by 
// induction on n:  ∑(i² | i: 1 ≤ i ≤ n) = n(n+1)(2n+1)/6
// To avoid reasoning about integer division, the lemma proves the
// equivalent division-free form:  6 * SumSquares(n) = n(n+1)(2n+1)
lemma {:induction false} SumSquaresFormula(n:nat)
  ensures 6 * SumSquares(n) == n * (n + 1) * (2*n + 1)
  decreases n
{
  if n > 0 
  {
      // Induction hypothesis:
      //   6 * SumSquares(n-1) = (n-1) * n * (2*(n-1) + 1)
    SumSquaresFormula(n-1);

      // Induction step:
    calc 
    {
      6 * SumSquares(n);
        // Unfold SumSquares(n)
      == 6 * (SumSquares(n-1) + n*n);
        // Distribute 6 over the sum
      == 6 * SumSquares(n-1) + 6*n*n;
        // Apply the induction hypothesis to SumSquares(n-1)
      == (n-1) * n * (2*(n-1) + 1) + 6*n*n;
        // Simplify the polynomial
      == (n-1) * n * (2*n - 1) + 6*n*n;
        // Factor out n from both terms
      == n * ((n-1) * (2*n - 1) + 6*n);
        // Expand the first term and combine like terms
      == n * (2*n*n + 3*n + 1);
        // Factor the quadratic polynomial
      == n * (n + 1) * (2*n + 1);
    }
  }

  else
  {
      // Base case: n = 0
      // The sum is empty, so SumSquares(0) = 0. Both
      // sides of the formula are therefore equal to 0.
    assert 6 * SumSquares(0) == 0 * (0 + 1) * (2*0 + 1);
  }
}