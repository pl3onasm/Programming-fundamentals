/*  file: sol11.dfy
    author: David De Potter
    description: proof by induction that the product of three
    consecutive natural numbers is divisible by 6
*/

include "../prob10/sol10.dfy"

//========================================================================
// Proves by induction on n that the product of three consecutive natural
// numbers is divisible by 6.
lemma {:induction false} ThreeConsecutiveDivisibleBySix(n:nat)
  ensures exists k:int :: n * (n+1) * (n+2) == 6*k
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true. The value 0 is a witness 
      // because 0 * 1 * 2 = 0 = 6 * 0
    assert exists k:int :: n * (n+1) * (n+2) == 6*k by
    {
      var k0:int := 0;

      calc
      {
        n * (n+1) * (n+2);
          // Since n = 0
        == 0 * 1 * 2;
          // Arithmetic
        == 0;
          // Arithmetic
        == 6*k0;
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   there exists some k such that (n-1) * n * (n+1) = 6*k
    ThreeConsecutiveDivisibleBySix(n-1);

      // The induction hypothesis gives an existential statement.
      // We use Dafny's assign-such-that operator :| to choose a witness
      // k from the induction hypothesis, so that we can use it in the
      // induction step. The witness k is an integer such that:
      //   (n-1) * n * (n+1) = 6*k
    var k:int :| (n-1) * n * (n+1) == 6*k;

      // Use the previous exercise to show that n(n+1) is divisible by 2
    TwoConsecutiveDivisibleByTwo(n);

      // Choose a witness q such that n(n+1) = 2*q
    var q:int :| n * (n+1) == 2*q;

      // Induction step
      // Prove Q(n) is true 
    calc
    {
      n * (n+1) * (n+2);
        // Rewrite using the previous product (n-1)n(n+1)
      == (n-1) * n * (n+1) + 3 * n * (n+1);
        // Apply the induction hypothesis and n(n+1) = 2*q
      == 6*k + 3 * (2*q);
        // Factor out 6
      == 6 * (k + q);
    }

      // The calculation shows that k + q is a witness for Q(n)
    assert exists p:int :: n * (n+1) * (n+2) == 6*p by
    {
      var p0:int := k + q;
      assert n * (n+1) * (n+2) == 6*p0;
    }
  }
}