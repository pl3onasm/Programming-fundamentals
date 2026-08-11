/*  file: prob01.dfy
    author: your name
    description: extra practice in Dafny, structural induction, 
    prob01
*/

//========================================================================
// Recursively adds a to every element of the integer sequence xs.
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
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q([]):
        Show that  AddToEach(a, AddToEach(b, []))
                   = AddToEach(a+b, [])

      Inductive case, Q(xs[1..]) ⇒ Q(xs):
        Assume that  AddToEach(a, AddToEach(b, xs[1..]))
                     = AddToEach(a+b, xs[1..])

        Then prove, for nonempty xs, that
          AddToEach(a, AddToEach(b, xs))
          = AddToEach(a+b, xs)

    Distinguish the two structural cases using |xs| = 0 and |xs| > 0.

    In the inductive case, call AddToEachComposition recursively on
    xs[1..]. Since |xs[1..]| = |xs| - 1, this call supplies the
    induction hypothesis for the structurally smaller tail of xs.
  */
}