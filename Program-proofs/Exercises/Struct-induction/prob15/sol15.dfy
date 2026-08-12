/*  file: sol15.dfy
    author: David De Potter
    description: proof by structural induction that Map distributes
      over list concatenation
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// Proves by structural induction on xs that Map distributes over Append:
//   Map(f, Append(xs, ys)) = Append(Map(f, xs), Map(f, ys))
lemma {:induction false} MapAppend<T, U>(f:T -> U, xs:List<T>, ys:List<T>)
  ensures Map(f, Append(xs, ys)) == Append(Map(f, xs), Map(f, ys))
  decreases xs
{
  if xs == Nil
  {
      // Base case: Q(Nil) is true
    assert Map(f, Append(xs, ys)) == Append(Map(f, xs), Map(f, ys)) by
    {
      calc
      {
        Map(f, Append(xs, ys));
          // Replace xs by Nil
        == Map(f, Append(Nil, ys));
          // Unfold Append(Nil, ys)
        == Map(f, ys);
          // Fold Append introducing Nil on the left
        == Append(Nil, Map(f, ys));
          // Fold Map
        == Append(Map(f, Nil), Map(f, ys));
          // Replace Nil by xs
        == Append(Map(f, xs), Map(f, ys));
      }
    }
  }

  else
  {
      // Since xs ≠ Nil, it has the form Cons(xs.head, xs.tail).
      // Let x and tail denote its head and structurally smaller tail.
    var x    := xs.head;
    var tail := xs.tail;

      // Induction hypothesis
      // Assume Q(tail) is true:
      //   Map(f, Append(tail, ys)) = Append(Map(f, tail), Map(f, ys))
    MapAppend(f, tail, ys);

      // Inductive case
      // Prove Q(Cons(x, tail)) is true
    calc
    {
      Map(f, Append(xs, ys));
        // Replace xs by Cons(x, tail)
      == Map(f, Append(Cons(x, tail), ys));
        // Unfold Append on its first argument
      == Map(f, Cons(x, Append(tail, ys)));
        // Unfold Map
      == Cons(f(x), Map(f, Append(tail, ys)));
        // Apply the induction hypothesis
      == Cons(f(x), Append(Map(f, tail), Map(f, ys)));
        // Fold Append on its first argument
      == Append(Cons(f(x), Map(f, tail)), Map(f, ys));
        // Fold Map(f, Cons(x, tail))
      == Append(Map(f, Cons(x, tail)), Map(f, ys));
        // Replace Cons(x, tail) by xs
      == Append(Map(f, xs), Map(f, ys));
    }
  }
}
