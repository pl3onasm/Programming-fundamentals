/*  file: sol02.dfy
    author: David De Potter
    description: proof by induction of the formula for the sum of the
    first n odd integers
*/

//========================================================================
// Recursively defines the sum of the first n odd integers:
//   SumOdd(n) = ∑(2*i - 1 | i: 1 ≤ i ≤ n)
// The empty sum is 0, so SumOdd(0) = 0. For n > 0, the final odd
// number 2*n - 1 is added to the sum of the first n-1 odd integers.
ghost function SumOdd(n:nat): nat
  decreases n
{
  if n == 0 then 0
            else SumOdd(n-1) + 2*n - 1
}

//========================================================================
// Proves the following formula for the sum of the first n odd integers
// by induction on n:  ∑(2*i - 1 | i: 1 ≤ i ≤ n) = n²
lemma {:induction false} SumOddFormula(n:nat)
  ensures SumOdd(n) == n*n
  decreases n
{
  if n == 0
    {
      // Base case: Q(0) is true
    assert SumOdd(0) == 0*0;
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   SumOdd(n-1) = (n-1)²
    SumOddFormula(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      SumOdd(n);
        // Unfold SumOdd(n)
      == SumOdd(n-1) + 2*n - 1;
        // Apply the induction hypothesis
      == (n-1)*(n-1) + 2*n - 1;
        // Expand the square
      == n*n - 2*n + 1 + 2*n - 1;
        // Simplify
      == n*n;
    }
  }

}