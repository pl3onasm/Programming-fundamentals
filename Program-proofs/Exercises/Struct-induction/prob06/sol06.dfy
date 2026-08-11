/*  file: sol06.dfy
    author: David De Potter
    description: proof by structural induction that reversing a
    sequence twice returns the original sequence
*/

include "../prob05/sol05.dfy"

//========================================================================
// Proves by structural induction on xs that reversing a sequence twice
// returns the original sequence:  Reverse(Reverse(xs)) = xs
lemma {:induction false} ReverseTwice(xs:seq<int>)
  ensures Reverse(Reverse(xs)) == xs
  decreases |xs|
{
  if |xs| == 0
  {
      // Base case: Q([]) is true
    assert Reverse(Reverse(xs)) == xs by
    {
      calc
      {
        Reverse(Reverse(xs));
          // A sequence of length 0 is the empty sequence
        == Reverse(Reverse([]));
          // Unfold the inner application of Reverse
        == Reverse([]);
          // Unfold the outer application of Reverse
        == [];
          // Replace [] by xs
        == xs;
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(xs[1..]) is true: Reverse(Reverse(xs[1..])) = xs[1..]
      // Since |xs[1..]| = |xs| - 1, the recursive call supplies the
      // induction hypothesis for the structurally smaller tail.
    ReverseTwice(xs[1..]);

      // This is the lemma proved in problem05: reversing a 
      // concatenation reverses the order of its two parts. Here we
      // apply it to the reversed tail and the singleton [xs[0]].
    ReverseConcat(Reverse(xs[1..]), [xs[0]]);

      // Reversing a singleton sequence leaves it unchanged.
    assert Reverse([xs[0]]) == [xs[0]];

      // Inductive case
      // Prove Q(xs) is true.
    calc
    {
      Reverse(Reverse(xs));
        // Unfold the inner application of Reverse
      == Reverse(Reverse(xs[1..]) + [xs[0]]);
        // Apply ReverseConcat
      == Reverse([xs[0]]) + Reverse(Reverse(xs[1..]));
        // Reverse leaves a singleton sequence unchanged
      == [xs[0]] + Reverse(Reverse(xs[1..]));
        // Apply the induction hypothesis
      == [xs[0]] + xs[1..];
        // Reconstruct xs from its head and tail
      == xs;
    }
  }
}