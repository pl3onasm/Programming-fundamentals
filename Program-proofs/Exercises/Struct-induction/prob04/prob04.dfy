/*  file: prob04.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob04
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
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q([]):
      
        Show that     SequenceSum([])
                      = SequenceSum(Reverse([]))

      Inductive case, Q(xs[1..]) ⇒ Q(xs):

        Assume that   SequenceSum(xs[1..])
                      = SequenceSum(Reverse(xs[1..]))

        and prove, for nonempty xs, that

                      SequenceSum(xs)
                      = SequenceSum(Reverse(xs))

    Use SequenceSumConcat from the solution to problem03. 
    It is included at the top of this file.

  */
}