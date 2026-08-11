/*  file: prob03.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob03
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
// Proves that SequenceSum distributes over sequence concatenation:
//   SequenceSum(xs + ys) = SequenceSum(xs) + SequenceSum(ys)
lemma {:induction false} SequenceSumConcat(xs:seq<int>, ys:seq<int>)
  ensures SequenceSum(xs + ys) == SequenceSum(xs) + SequenceSum(ys)
  decreases |xs|
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q([]):
        Show that  SequenceSum([] + ys)
                   = SequenceSum([]) + SequenceSum(ys)

      Inductive case, Q(xs[1..]) ⇒ Q(xs):
        Assume that  SequenceSum(xs[1..] + ys)
                     = SequenceSum(xs[1..]) + SequenceSum(ys)

        and prove, for nonempty xs, that
          SequenceSum(xs + ys)
          = SequenceSum(xs) + SequenceSum(ys)

    You may find the following properties useful:
      - The empty sequence is a left identity for sequence 
        concatenation:
          [] + ys = ys
      - The first element of xs + ys is the first element 
        of xs:
          (xs + ys)[0] = xs[0]
      - The tail of xs + ys is the tail of xs concatenated 
        with ys:
          (xs + ys)[1..] = xs[1..] + ys
  */
}