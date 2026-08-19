/*  file: prob05.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob05
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
  /*
    The function Reverse is defined in the solution to problem04.

    Prove this lemma by structural induction on xs.

      Base case, Q([]):
      
        Show that     Reverse([] + ys)
                      = Reverse(ys) + Reverse([])

      Inductive case, Q(xs[1..]) ⇒ Q(xs):
      
        Assume that   Reverse(xs[1..] + ys)
                      = Reverse(ys) + Reverse(xs[1..])

        and prove, for nonempty xs, that

                      Reverse(xs + ys)
                      = Reverse(ys) + Reverse(xs)

    You may find the following properties useful:
      - The empty sequence is a left and right identity for  
        sequence concatenation:
          [] + xs = xs
          xs + [] = xs
      - The first element of xs + ys is the first element 
        of xs:
          (xs + ys)[0] = xs[0]
      - The tail of xs + ys is the tail of xs concatenated 
        with ys:
          (xs + ys)[1..] = xs[1..] + ys
      - Sequence concatenation is associative:
          (xs + ys) + zs = xs + (ys + zs)

    If you need to use any of these properties, you can 
    simply assert them in your proof.
    
  */
}