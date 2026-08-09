/*  file: sol08.dfy
    author: David De Potter
    description: proof by induction that 3 divides n³ - n for every
    positive integer n
*/

//========================================================================
// Proves by induction on n that 3 divides n³ - n, for every positive
// integer n.
lemma {:induction false} DivisibleByThree(n:nat)
  requires n > 0
  ensures  exists k:int :: n*n*n - n == 3*k
  decreases n
{
  if n == 1
  {
      // Base case: Q(1) is true. The value 0 is a witness 
      // because 1³ - 1 = 0 = 3 * 0
    assert exists k:int :: n*n*n - n == 3*k by
    {
      var k0:int := 0;
      calc
      {
        n*n*n - n;
          // Since n = 1
        == 1*1*1 - 1;
          // Arithmetic
        == 0;
          // Arithmetic
        == 3*k0;
      }
    }
  }

  else
  {
      // Abbreviate n-1 by m to keep the calculation compact
    var m:nat := n-1;

      // Induction hypothesis
      // Assume Q(m) is true:
      //   there exists some k such that m³ - m = 3*k
    DivisibleByThree(m);

      // The induction hypothesis gives an existential statement.
      // We use Dafny's assign-such-that operator :| to choose a witness
      // k from the induction hypothesis, so that we can use it in the
      // induction step. The witness k is an integer such that:
      //     m³ - m = 3*k
    var k:int :| m*m*m - m == 3*k;

      // Induction step
      // Prove Q(n) is true.
    calc
    {
      n*n*n - n;
        // Replace n by m+1
      == (m+1)*(m+1)*(m+1) - (m+1);
        // Expand the cubic expression
      == m*m*m + 3*m*m + 3*m + 1 - (m+1);
        // Regroup the terms to isolate m³-m
        // to which the induction hypothesis can be applied
      == (m*m*m - m) + 3*(m+1)*m;
        // Replace m+1 by n
      == (m*m*m - m) + 3*n*m;
        // Apply the induction hypothesis
      == 3*k + 3*n*m;
        // Factor out 3
      == 3 * (k + n*m);
    }

      // The calculation shows that k + n*m is a witness for Q(n).
    assert exists q:int :: n*n*n - n == 3*q by
    {
      var q0:int := k + n*m;
      assert n*n*n - n == 3*q0;
    }
  }
}