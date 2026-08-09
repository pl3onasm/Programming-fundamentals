/*  file: sol06.dfy
    author: David De Potter
    description: proof by induction of the inequality 1 + 2^n < 3^n
*/

//========================================================================
// Recursively defines 2^n.
ghost function Pow2(n:nat): nat
  decreases n
{
  if n == 0 then 1
            else 2 * Pow2(n-1)
}

//========================================================================
// Recursively defines 3^n.
ghost function Pow3(n:nat): nat
  decreases n
{
  if n == 0 then 1
            else 3 * Pow3(n-1)
}

//========================================================================
// Proves the following inequality by induction on n:
//   1 + 2^n < 3^n, for n ≥ 2
lemma {:induction false} PowersInequality(n:nat)
  requires n >= 2
  ensures  1 + Pow2(n) < Pow3(n)
  decreases n
{
  if n == 2
  {
      // Base case: Q(2) is true
    assert 1 + Pow2(2) < Pow3(2) by
    {
      calc
      {
        1 + Pow2(2);
          // Unfold Pow2(2)
        == 1 + 2 * Pow2(1);
          // Unfold Pow2(1)
        == 1 + 2 * (2 * Pow2(0));
          // Unfold Pow2(0)
        == 1 + 2 * (2 * 1);
          // Arithmetic
        == 5;
          // Arithmetic
        < 9;
          // Fold Pow3(2)
        == Pow3(2);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   1 + 2^(n-1) < 3^(n-1)
    PowersInequality(n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      1 + Pow2(n);
        // Unfold Pow2(n)
      == 1 + 2 * Pow2(n-1);
        // Arithmetic
      < 2 + 2 * Pow2(n-1);
        // Factor out 2
      == 2 * (1 + Pow2(n-1));
        // Apply the induction hypothesis
      < 2 * Pow3(n-1);
        // Since Pow3(n-1) > 0
      < 3 * Pow3(n-1);
        // Rewrite 3 * Pow3(n-1) as Pow3(n)
      == Pow3(n);
    }
  }
}