/*  file: sol09.dfy
    author: David De Potter
    description: proof by induction that 2 divides n² - n
*/

//========================================================================
// Proves by induction on n that 2 divides n² - n.
lemma {:induction false} DivisibleByTwo(n:nat)
  ensures exists k:int :: n*n - n == 2*k
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true.
      // The value 0 is a witness because 0² - 0 = 0 = 2 * 0
    assert exists k:int :: n*n - n == 2*k by
    {
      var k0:int := 0;
      
      calc
      {
        n*n - n;
          // Since n = 0
        == 0*0 - 0;
          // Arithmetic
        == 0;
          // Arithmetic
        == 2*k0;
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   there exists some k such that (n-1)² - (n-1) = 2*k
    DivisibleByTwo(n-1);

      // The induction hypothesis gives an existential statement.
      // We use Dafny's assign-such-that operator :| to choose a witness
      // k from the induction hypothesis, so that we can use it in the
      // induction step. The witness k is an integer such that:
      //   (n-1)² - (n-1) = 2*k
    var k:int :| (n-1)*(n-1) - (n-1) == 2*k;

      // Induction step
      // Prove Q(n) is true. 
    calc
    {
      n*n - n;
        // Rewrite n² - n using the previous term (n-1)² - (n-1)
      == ((n-1)*(n-1) - (n-1)) + 2*(n-1);
        // Apply the induction hypothesis
      == 2*k + 2*(n-1);
        // Factor out 2
      == 2 * (k + (n-1));
    }

      // The calculation shows that k + (n-1) is a witness for Q(n)
    assert exists q:int :: n*n - n == 2*q by
    {
      var q0:int := k + (n-1);
      assert n*n - n == 2*q0;
    }
  }
}