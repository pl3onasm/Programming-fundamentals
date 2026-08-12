/*  file: sol13.dfy
    author: David De Potter
    description: proof by structural induction of the length of two
      appended lists
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// Proves by structural induction on xs that the length of two appended
// lists is the sum of their separate lengths:
//   Length(Append(xs, ys)) = Length(xs) + Length(ys)
lemma {:induction false} LengthAppend<T>(xs:List<T>, ys:List<T>)
  ensures Length(Append(xs, ys)) == Length(xs) + Length(ys)
  decreases xs
{
  if xs == Nil
  {
      // Base case: Q(Nil) is true
    assert Length(Append(xs, ys)) == Length(xs) + Length(ys) by
    {
      calc
      {
        Length(Append(xs, ys));
          // Replace xs by Nil
        == Length(Append(Nil, ys));
          // Unfold Append(Nil, ys)
        == Length(ys);
          // Arithmetic
        == 0 + Length(ys);
          // Since xs = Nil, Length(xs) = 0
        == Length(xs) + Length(ys);
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
      //   Length(Append(tail, ys)) = Length(tail) + Length(ys)
    LengthAppend(tail, ys);

      // Inductive case
      // Prove Q(Cons(x, tail)) is true
    calc
    {
      Length(Append(xs, ys));
        // Replace xs by Cons(x, tail)
      == Length(Append(Cons(x, tail), ys));
        // Unfold Append on its first argument
      == Length(Cons(x, Append(tail, ys)));
        // Unfold Length
      == 1 + Length(Append(tail, ys));
        // Apply the induction hypothesis
      == 1 + (Length(tail) + Length(ys));
        // Addition is associative
      == (1 + Length(tail)) + Length(ys);
        // Fold Length
      == Length(Cons(x, tail)) + Length(ys);
        // Replace Cons(x, tail) by xs
      == Length(xs) + Length(ys);
    }
  }
}
