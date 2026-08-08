/*  file: sol08.dfy
    author: David De Potter
    description: proof by induction that 3 divides n³ - n for every
    positive integer n
*/

//========================================================================
// Proves by induction on n that 3 divides n³ - n, for every positive
// integer n.
lemma {:induction false} DivisibleByThree(n:nat)
  requires 1 <= n
  ensures  exists k:int :: n*n*n - n == 3*k
  decreases n
{
  if n == 1
  {
      // Base case: Q(1) is true for k = 0
      // We have 1³ - 1 = 0 = 3 * 0.
    assert n*n*n - n == 3*0;
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   there exists some k such that (n-1)³ - (n-1) = 3*k
    DivisibleByThree(n-1);

      // The induction hypothesis gives an existential statement.
      // We use Dafny's assign-such-that operator :| to choose a witness
      // k from the induction hypothesis, so that we can use it in the
      // induction step. The witness k is an integer such that:
      //   (n-1)³ - (n-1) = 3*k
    var k:int :| (n-1)*(n-1)*(n-1) - (n-1) == 3*k;

      // Induction step
      // Prove Q(n) is true. 
    calc
    {
      n*n*n - n;
        // In order to be able to apply the induction hypothesis,
        // substute n = (n-1)+1 
      == ((n-1)+1) * ((n-1)+1) * ((n-1)+1) - ((n-1)+1);
        // Expand the cubic expression
      == (n-1)*(n-1)*(n-1) + 3*(n-1)*(n-1) + 3*(n-1) + 1 - ((n-1)+1);
        // Combine like terms
      == ((n-1)*(n-1)*(n-1) - (n-1)) + 3*((n-1)+1)*(n-1);
        // Replace (n-1)+1 by n
      == ((n-1)*(n-1)*(n-1) - (n-1)) + 3*n*(n-1);
        // Apply the induction hypothesis
      == 3*k + 3*n*(n-1);
        // Factor out 3
      == 3 * (k + n*(n-1));
    }
  }
}