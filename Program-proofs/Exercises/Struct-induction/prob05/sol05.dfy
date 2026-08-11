/*  file: sol05.dfy
    author: David De Potter
    description: proof by structural induction that reversing a
    concatenation reverses the order of its two parts
*/

include "../prob04/sol04.dfy"

//========================================================================
// Proves by structural induction on xs that reversing a concatenation
// reverses the order of its two parts:
//   Reverse(xs + ys) = Reverse(ys) + Reverse(xs)
lemma {:induction false} ReverseConcat(xs:seq<int>, ys:seq<int>)
  ensures Reverse(xs + ys) == Reverse(ys) + Reverse(xs)
  decreases |xs|
{
  if |xs| == 0
  {
      // Base case: Q([]) is true

      // The empty sequence is a left and right identity for
      // sequence concatenation.
    assert [] + ys == ys;
    assert ys + [] == ys;

      // Prove Q([]) is true:
      //   Reverse([] + ys) = Reverse(ys) + Reverse([])
    assert Reverse(xs + ys) == Reverse(ys) + Reverse(xs) by
    {
      calc
      {
        Reverse(xs + ys);
          // A sequence of length 0 is the empty sequence
        == Reverse([] + ys);
          // Use [] + ys = ys
        == Reverse(ys);
          // Use ys + [] = ys
        == Reverse(ys) + [];
          // Fold Reverse([])
        == Reverse(ys) + Reverse([]);
          // Replace [] by xs
        == Reverse(ys) + Reverse(xs);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(xs[1..]) is true:
      //   Reverse(xs[1..] + ys) = Reverse(ys) + Reverse(xs[1..])
      // Since |xs[1..]| = |xs| - 1, the recursive call supplies the
      // induction hypothesis for the structurally smaller tail.
    ReverseConcat(xs[1..], ys);

      // The first element of xs + ys is the first element of xs
    assert (xs + ys)[0] == xs[0];
      // The tail of xs + ys is the tail of xs concatenated with ys
    assert (xs + ys)[1..] == xs[1..] + ys;

      // Inductive case
      // Prove Q(xs) is true.
    calc
    {
      Reverse(xs + ys);
        // Unfold Reverse on the nonempty sequence xs + ys
      == Reverse((xs + ys)[1..]) + [(xs + ys)[0]];
        // Use the assertions above
      == Reverse(xs[1..] + ys) + [xs[0]];
        // Apply the induction hypothesis
      == (Reverse(ys) + Reverse(xs[1..])) + [xs[0]];
        // Use associativity of concatenation
      == Reverse(ys) + (Reverse(xs[1..]) + [xs[0]]);
        // Fold Reverse(xs)
      == Reverse(ys) + Reverse(xs);
    }
  }
}