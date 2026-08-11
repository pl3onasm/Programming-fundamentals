/*  file: sol02.dfy
    author: David De Potter
    description: proof by structural induction that AddToEach
    distributes over sequence concatenation
*/

//========================================================================
// Recursively adds a to every element of the integer sequence xs.
ghost function AddToEach(a:int, xs:seq<int>): seq<int>
  decreases |xs|
{
  if |xs| == 0 then []
               else [a + xs[0]] + AddToEach(a, xs[1..])
}

//========================================================================
// Proves by structural induction on xs that AddToEach distributes over
// sequence concatenation:
//   AddToEach(a, xs + ys) = AddToEach(a, xs) + AddToEach(a ,ys)
lemma {:induction false} AddToEachConcat(a:int, xs:seq<int>, ys:seq<int>)
  ensures AddToEach(a, xs + ys) == AddToEach(a, xs) + AddToEach(a, ys)
  decreases |xs|
{
  if |xs| == 0
  {
      // Base case: Q([]) is true

      // The empty sequence is a left identity for concatenation
    assert [] + ys == ys;

    assert AddToEach(a,xs + ys) == AddToEach(a,xs) + AddToEach(a,ys) by
    {
      calc
      {
        AddToEach(a, xs + ys);
          // A sequence of length 0 is the empty sequence
        == AddToEach(a, [] + ys);
          // Use [] + ys = ys
        == AddToEach(a, ys);
          // Introduce the empty sequence on the left
        == [] + AddToEach(a, ys);
          // Fold AddToEach(a,[])
        == AddToEach(a, []) + AddToEach(a ,ys);
          // Replace [] by xs
        == AddToEach(a, xs) + AddToEach(a, ys);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(xs[1..]) is true:
      //   AddToEach(a, xs[1..] + ys) 
      //   = AddToEach(a, xs[1..]) + AddToEach(a, ys)
      // Since xs is nonempty, xs[1..] is its tail and satisfies
      // |xs[1..]| = |xs| - 1. The recursive call therefore supplies
      // the induction hypothesis for this structurally smaller sequence
    AddToEachConcat(a,xs[1..], ys);

      // The first element of xs + ys is the first element of xs
    assert (xs + ys)[0] == xs[0];
      // The tail of xs + ys is the tail of xs concatenated with ys
    assert (xs + ys)[1..] == xs[1..] + ys;

      // Inductive case
      // Prove Q(xs) is true.
    calc
    {
      AddToEach(a, xs + ys);
        // Unfold AddToEach on the nonempty sequence xs + ys
      == [a + (xs + ys)[0]] + AddToEach(a, (xs + ys)[1..]);
        // Use the properties of the head and tail of xs + ys
      == [a + xs[0]] + AddToEach(a, xs[1..] + ys);
        // Apply the induction hypothesis
      == [a + xs[0]] + (AddToEach(a, xs[1..]) + AddToEach(a, ys));
        // Use associativity of sequence concatenation
      == ([a + xs[0]] + AddToEach(a, xs[1..])) + AddToEach(a, ys);
        // Fold AddToEach(a,xs)
      == AddToEach(a, xs) + AddToEach(a, ys);
    }
  }
}