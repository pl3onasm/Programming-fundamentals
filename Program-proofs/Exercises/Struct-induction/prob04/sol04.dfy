/*  file: sol04.dfy
    author: David De Potter
    description: proof by structural induction that reversing a
    sequence preserves the sum of its elements
*/

include "../prob03/sol03.dfy"

//========================================================================
// Recursively reverses the sequence xs.
// The expression [xs[0]] is a singleton sequence, and + denotes
// Dafny's built-in sequence concatenation.
ghost function Reverse(xs:seq<int>): seq<int>
  decreases |xs|
{
  if |xs| == 0 then []
               else Reverse(xs[1..]) + [xs[0]]
}

//========================================================================
// Proves by structural induction on xs that reversing a sequence does
// not change the sum of its elements:
//   SequenceSum(xs) = SequenceSum(Reverse(xs))
lemma {:induction false} ReversePreservesSum(xs:seq<int>)
  ensures SequenceSum(xs) == SequenceSum(Reverse(xs))
  decreases |xs|
{
  if |xs| == 0
  {
      // Base case: Q([]) is true
    assert SequenceSum(xs) == SequenceSum(Reverse(xs)) by
    {
      calc
      {
        SequenceSum(xs);
          // A sequence of length 0 is the empty sequence
        == SequenceSum([]);
          // Fold Reverse on the empty sequence
        == SequenceSum(Reverse([]));
          // Replace [] by xs
        == SequenceSum(Reverse(xs));
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(xs[1..]) is true:
      //   SequenceSum(xs[1..]) = SequenceSum(Reverse(xs[1..]))
      // Since |xs[1..]| = |xs| - 1, the recursive call supplies the
      // induction hypothesis for the structurally smaller tail.
    ReversePreservesSum(xs[1..]);
      
      // This is the lemma proved in problem03: SequenceSum distributes 
      // over sequence concatenation. Here we apply it to the reversed 
      // tail and the singleton sequence [xs[0]].
    SequenceSumConcat(Reverse(xs[1..]), [xs[0]]);

      // Inductive case
      // Prove Q(xs) is true.
    calc
    {
      SequenceSum(xs);
        // Unfold SequenceSum(xs)
      == xs[0] + SequenceSum(xs[1..]);
        // Reorder the sum to put the tail first
      == SequenceSum(xs[1..]) + xs[0];
        // Apply the induction hypothesis
      == SequenceSum(Reverse(xs[1..])) + xs[0];
        // Rewrite xs[0] as the sum of the singleton [xs[0]]
      == SequenceSum(Reverse(xs[1..])) + SequenceSum([xs[0]]);
        // Apply SequenceSumConcat in reverse direction
      == SequenceSum(Reverse(xs[1..]) + [xs[0]]);
        // Fold Reverse(xs)
      == SequenceSum(Reverse(xs));
    }
  }
}