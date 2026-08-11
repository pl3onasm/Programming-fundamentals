/*  file: prob06.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob06
*/

include "../prob05/sol05.dfy"

//========================================================================
// Proves by structural induction on xs that reversing a sequence twice
// returns the original sequence:  Reverse(Reverse(xs)) = xs
lemma {:induction false} ReverseTwice(xs:seq<int>)
  ensures Reverse(Reverse(xs)) == xs
  decreases |xs|
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q([]):
        Show that  Reverse(Reverse([])) = []

      Inductive case, Q(xs[1..]) ⇒ Q(xs):
        Assume that  Reverse(Reverse(xs[1..])) = xs[1..]

        and prove, for nonempty xs, that
          Reverse(Reverse(xs)) = xs

    Use ReverseConcat from the solution to problem05.
    It is included at the top of this file.

    You may find the following property useful.
    Reversing a singleton sequence leaves it unchanged:
      Reverse([x]) = [x]

  */
}