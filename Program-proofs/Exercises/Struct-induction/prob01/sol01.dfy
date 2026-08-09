/*  file: sol01.dfy
    author: David De Potter
    description: proof by structural induction that adding two values
    successively to a sequence is equivalent to adding their sum
*/

//========================================================================
// Recursively adds a to every element of the integer sequence xs.
// The empty sequence remains empty. For a nonempty sequence, a is added
// to the first element, after which the function continues recursively
// with the tail.
// The expression [a + xs[0]] is a singleton sequence, and + denotes
// Dafny's built-in sequence concatenation. For a nonempty sequence xs, 
// the slice xs[1..] denotes its tail: the sequence obtained by removing 
// the first element.
ghost function AddToEach(a:int, xs:seq<int>): seq<int>
  decreases |xs|
{
  if |xs| == 0 then []
               else [a + xs[0]] + AddToEach(a, xs[1..])
}

//========================================================================
// Proves by structural induction on xs that adding b to every element
// and then adding a is equivalent to adding a+b once to every element:
//   AddToEach(a, AddToEach(b, xs)) = AddToEach(a+b, xs)
lemma {:induction false} AddToEachComposition(a:int, b:int, xs:seq<int>)
  ensures AddToEach(a, AddToEach(b, xs)) == AddToEach(a+b, xs)
  decreases |xs|
{
  if |xs| == 0
  {
      // Base case: Q([]) is true
      // A sequence of length 0 is the empty sequence.
    assert xs == [];

    assert AddToEach(a, AddToEach(b, xs)) == AddToEach(a+b, xs) by
    {
      calc
      {
        AddToEach(a, AddToEach(b, xs));
          // Replace xs by []
        == AddToEach(a, AddToEach(b, []));
          // Unfold the inner application
        == AddToEach(a, []);
          // Unfold the outer application
        == [];
          // Fold AddToEach(a+b, [])
        == AddToEach(a+b, []);
          // Replace [] by xs
        == AddToEach(a+b, xs);
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(xs[1..]) is true:
      //   AddToEach(a, AddToEach(b, xs[1..])) = AddToEach(a+b, xs[1..])
      // Since xs is nonempty, xs[1..] is its tail and satisfies
      // |xs[1..]| = |xs| - 1. It is therefore structurally smaller
      // than xs, so the recursive call supplies the induction hypothesis.
    AddToEachComposition(a, b, xs[1..]);

      // Inductive case
      // Prove Q(xs) is true.
    calc
    {
      AddToEach(a, AddToEach(b,xs));
        // Unfold the inner application of AddToEach
      == AddToEach(a, [b + xs[0]] + AddToEach(b, xs[1..]));
        // Unfold the outer application of AddToEach
      == [a + (b + xs[0])] + AddToEach(a, AddToEach(b, xs[1..]));
        // Integer addition is associative
      == [(a+b) + xs[0]] + AddToEach(a, AddToEach(b, xs[1..]));
        // Apply the induction hypothesis
      == [(a+b) + xs[0]] + AddToEach(a+b, xs[1..]);
        // Fold AddToEach(a+b,xs)
      == AddToEach(a+b, xs);
    }
  }
}