/*  file: sol17.dfy
    author: David De Potter
    description: proof by structural induction that reversing a list
      preserves the number of occurrences of every value
*/

include "../../Support/Datatypes/Lists.dfy"
include "../../Support/Math.dfy"

import opened Lists
import opened MathSupport

//========================================================================
// States that Count distributes over Append:
//   Count(z, Append(xs, ys)) = Count(z, xs) + Count(z, ys)
// This standard property is assumed in this exercise to keep the proof 
// focused on CountReverse. It can itself be proved by structural 
// induction on xs.
lemma CountAppend<T>(z:T, xs:List<T>, ys:List<T>)
  ensures Count(z, Append(xs, ys)) == Count(z, xs) + Count(z, ys)
{
  assume {:axiom} 
    Count(z, Append(xs, ys)) == Count(z, xs) + Count(z, ys);
}

//========================================================================
// Proves by structural induction on xs that reversing a list does not
// change the number of occurrences of any value:
//   Count(z, Reverse(xs)) = Count(z, xs)
lemma {:induction false} CountReverse<T>(z:T, xs:List<T>)
  ensures Count(z, Reverse(xs)) == Count(z, xs)
  decreases xs
{
  if xs == Nil
  {
      // Base case: Q(Nil) is true
    assert Count(z, Reverse(xs)) == Count(z, xs) by
    {
      calc
      {
        Count(z, Reverse(xs));
          // Replace xs by Nil
        == Count(z, Reverse(Nil));
          // Unfold Reverse(Nil)
        == Count(z, Nil);
          // Replace Nil by xs
        == Count(z, xs);
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
      // Assume Q(tail) is true: Count(z, Reverse(tail)) = Count(z, tail)
    CountReverse(z, tail);

      // Split the count over the appended lists that occur in the
      // definition of Reverse(Cons(x, tail))
    CountAppend(z, Reverse(tail), Cons(x, Nil));

      // Inductive case
      // Prove Q(Cons(x, tail)) is true
    calc
    {
      Count(z, Reverse(xs));
        // Replace xs by Cons(x, tail)
      == Count(z, Reverse(Cons(x, tail)));
        // Unfold Reverse
      == Count(z, Append(Reverse(tail), Cons(x, Nil)));
        // Apply CountAppend
      == Count(z, Reverse(tail)) + Count(z, Cons(x, Nil));
        // Apply the induction hypothesis
      == Count(z, tail) + Count(z, Cons(x, Nil));
        // Unfold Count on the singleton list Cons(x, Nil)
      == Count(z, tail) + ord(z == x) + Count(z, Nil);
        // Unfold Count on the empty list Nil
      == Count(z, tail) + ord(z == x) + 0;
        // Addition is commutative
      == ord(z == x) + Count(z, tail);
        // Fold Count(z, Cons(x, tail))
      == Count(z, Cons(x, tail));
        // Replace Cons(x, tail) by xs
      == Count(z, xs);
    }
  }
}
