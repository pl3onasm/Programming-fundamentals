/*  file: prob02.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob02
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
//   AddToEach(a, xs + ys) = AddToEach(a, xs) + AddToEach(a, ys)
lemma {:induction false} AddToEachConcat(a:int, xs:seq<int>, ys:seq<int>)
  ensures AddToEach(a,xs + ys) == AddToEach(a,xs) + AddToEach(a,ys)
  decreases |xs|
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q([]):
      
        Show that       AddToEach(a, [] + ys)
                        = AddToEach(a, []) + AddToEach(a, ys)

      Inductive case, Q(xs[1..]) ⇒ Q(xs):

        Assume that     AddToEach(a, xs[1..] + ys)
                        = AddToEach(a, xs[1..]) + AddToEach(a, ys)

        and prove, for nonempty xs, that

                        AddToEach(a, xs + ys)
                        = AddToEach(a, xs) + AddToEach(a, ys)

    In the inductive case, xs[1..] is structurally smaller than xs
    because |xs[1..]| = |xs| - 1. Call AddToEachConcat recursively
    on xs[1..] and ys to obtain the induction hypothesis.

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
      - Sequence concatenation is associative:
          (xs + ys) + zs = xs + (ys + zs)
          
    If you need to use any of these properties, you can simply 
    assert them in your proof.
  */
}