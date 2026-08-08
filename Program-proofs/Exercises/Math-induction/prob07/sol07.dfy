/*  file: sol07.dfy
    author: David De Potter
    description: proof by induction of an upper bound for the sum of
    the first n positive integers
*/

//========================================================================
// Recursively defines the sum of the first n positive integers:
//   Sum(n) = ∑(i | i: 1 ≤ i ≤ n)
ghost function Sum(n:nat): int
  decreases n
{
  if n == 0 then 0
            else Sum(n-1) + n
}

//========================================================================
// Proves the following inequality by induction on n:
//   1 + 2 + 3 + ... + n < (2n+1)² / 8
//
// To avoid reasoning about integer division, the lemma proves the
// equivalent division-free form:
//   8 * Sum(n) < (2n+1)²
lemma {:induction false} SumBound(n:nat)
  ensures 8 * Sum(n) < (2*n + 1) * (2*n + 1)
  decreases n
{
  if n == 0
    {
      // Base case: Q(0) is true
    assert 8 * Sum(0) < (2*0 + 1) * (2*0 + 1);
  }
  
  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   8 * Sum(n-1) < (2*(n-1) + 1)²
    SumBound(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      8 * Sum(n);
        // Unfold Sum(n)
      == 8 * (Sum(n-1) + n);
        // Distribute 8 over the sum
      == 8 * Sum(n-1) + 8*n;
        // Apply the induction hypothesis
      < (2*(n-1) + 1) * (2*(n-1) + 1) + 8*n;
        // Simplify the expression
      == (2*n - 1) * (2*n - 1) + 8*n;
        // Expand and combine like terms
      == 4*n*n + 4*n + 1;
        // Factor the squared expression
      == (2*n + 1) * (2*n + 1);
    }
  }

}