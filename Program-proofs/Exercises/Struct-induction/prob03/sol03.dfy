/*  file: sol03.dfy
    author: David De Potter
    description: proof by structural induction that SequenceSum
    distributes over sequence concatenation
*/

//========================================================================
// Recursively computes the sum of the elements of the integer sequence
// xs. 
ghost function SequenceSum(xs:seq<int>): int
  decreases |xs|
{
  if |xs| == 0 then 0
               else xs[0] + SequenceSum(xs[1..])
}

//========================================================================
// Proves by structural induction on xs that SequenceSum distributes over
// sequence concatenation:
//   SequenceSum(xs + ys) = SequenceSum(xs) + SequenceSum(ys)
lemma {:induction false} SequenceSumConcat(xs:seq<int>, ys:seq<int>)
  ensures SequenceSum(xs + ys) == SequenceSum(xs) + SequenceSum(ys)
  decreases |xs|
{
  if |xs| == 0
  {
      // Base case: Q([]) is true

      // The empty sequence is a left identity for concatenation
    assert [] + ys == ys;

    assert SequenceSum(xs + ys) == SequenceSum(xs) + SequenceSum(ys) by
    {
      calc
      {
        SequenceSum(xs + ys);
          // A sequence of length 0 is the empty sequence
        == SequenceSum([] + ys);
          // Use [] + ys = ys
        == SequenceSum(ys);
          // 0 is the identity for addition
        == 0 + SequenceSum(ys);
          // Fold SequenceSum([])
        == SequenceSum([]) + SequenceSum(ys);
          // Replace [] by xs
        == SequenceSum(xs) + SequenceSum(ys);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(xs[1..]) is true:
      //   SequenceSum(xs[1..] + ys)
      //   = SequenceSum(xs[1..]) + SequenceSum(ys)
      // Since |xs[1..]| = |xs| - 1, the recursive call supplies the
      // induction hypothesis for the structurally smaller tail.
    SequenceSumConcat(xs[1..],ys);

      // The first element of xs + ys is the first element of xs
    assert (xs + ys)[0] == xs[0];
      // The tail of xs + ys is the tail of xs concatenated with ys
    assert (xs + ys)[1..] == xs[1..] + ys;

      // Inductive case
      // Prove Q(xs) is true.
    calc
    {
      SequenceSum(xs + ys);
        // Unfold SequenceSum on the nonempty sequence xs + ys
      == (xs + ys)[0] + SequenceSum((xs + ys)[1..]);
        // Use the assertions above
      == xs[0] + SequenceSum(xs[1..] + ys);
        // Apply the induction hypothesis
      == xs[0] + (SequenceSum(xs[1..]) + SequenceSum(ys));
        // Integer addition is associative
      == (xs[0] + SequenceSum(xs[1..])) + SequenceSum(ys);
        // Fold SequenceSum(xs)
      == SequenceSum(xs) + SequenceSum(ys);
    }
  }
}