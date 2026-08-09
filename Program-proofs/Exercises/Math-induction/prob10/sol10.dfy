/*  file: sol10.dfy
    author: David De Potter
    description: proof by induction that the product of two consecutive
    natural numbers is divisible by 2
*/

//========================================================================
// Proves by induction on n that the product of two consecutive natural
// numbers is divisible by 2.
lemma {:induction false} TwoConsecutiveDivisibleByTwo(n:nat)
  ensures exists k:int :: n * (n+1) == 2*k
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true
      // We have 0 * 1 = 0 = 2 * 0.
    assert n * (n+1) == 2*0;
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   there exists some k such that (n-1) * n = 2*k
    TwoConsecutiveDivisibleByTwo(n-1);

      // The induction hypothesis gives an existential statement.
      // We use Dafny's assign-such-that operator :| to choose a witness
      // k from the induction hypothesis, so that we can use it in the
      // induction step. The witness k is an integer such that:
      //   (n-1) * n = 2*k
    var k:int :| (n-1) * n == 2*k;

      // Induction step
      // Prove Q(n) is true. 
    calc
    {
      n * (n+1);
        // Rewrite n(n+1) using the previous product (n-1)n
      == (n-1) * n + 2*n;
        // Apply the induction hypothesis
      == 2*k + 2*n;
        // Factor out 2
      == 2 * (k + n);
    }

      // The calculation shows that k + n is a witness for Q(n)
    assert exists q:int :: n * (n+1) == 2*q by
    {
      var q0:int := k + n;
      assert n * (n+1) == 2*q0;
    }
  }
}