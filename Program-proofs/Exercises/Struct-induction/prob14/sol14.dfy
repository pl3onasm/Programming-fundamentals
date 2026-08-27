/*  file: sol14.dfy
    author: David De Potter
    description: proof by structural induction that mapping a function
      over a list preserves its length
*/

include "../../Support/Datatypes/Finite/Lists.dfy"
import opened Lists

//========================================================================
// Proves by structural induction on xs that mapping a function over a
// list preserves its length:  Length(Map(f, xs)) = Length(xs)
lemma {:induction false} LengthMap<T, U>(f:T -> U, xs:List<T>)
  ensures Length(Map(f, xs)) == Length(xs)
  decreases xs
{
  if xs == Nil
  {
      // Base case: Q(Nil) is true
    assert Length(Map(f, xs)) == Length(xs) by
    {
      calc
      {
        Length(Map(f, xs));
          // Replace xs by Nil
        == Length(Map(f, Nil));
          // Unfold Map and Length
        == 0;
          // Since xs = Nil, Length(xs) = 0
        == Length(xs);
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
      // Assume Q(tail) is true:  Length(Map(f, tail)) = Length(tail)
    LengthMap(f, tail);
    
      // Inductive case
      // Prove Q(Cons(x, tail)) is true
    calc
    {
      Length(Map(f, xs));
        // Replace xs by Cons(x, tail)
      == Length(Map(f, Cons(x, tail)));
        // Unfold Map
      == Length(Cons(f(x), Map(f, tail)));
        // Unfold Length
      == 1 + Length(Map(f, tail));
        // Apply the induction hypothesis
      == 1 + Length(tail);
        // Fold Length
      == Length(Cons(x, tail));
        // Replace Cons(x, tail) by xs
      == Length(xs);
    }
  }
}
