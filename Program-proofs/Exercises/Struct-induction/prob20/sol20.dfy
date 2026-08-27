/*  file: sol20.dfy
    author: David De Potter
    description: proof by structural induction that filtering twice is 
    equivalent to filtering once with the conjunction of the two 
    predicates
*/

include "../../Support/Datatypes/Finite/Lists.dfy"
import opened Lists

//========================================================================
// Proves by structural induction on xs that filtering first with q and
// then with p is equivalent to filtering once with their conjunction:
//   Filter(p, Filter(q, xs)) = Filter(x => q(x) && p(x), xs)
lemma {:induction false} FilterComposition<T>(p:T -> bool, q:T -> bool, 
                                              xs:List<T>)
  ensures Filter(p, Filter(q, xs)) == Filter((x:T) => q(x) && p(x), xs)
  decreases xs
{
  if xs == Nil
  {
      // Base case: Q(Nil) is true
    assert Filter(p, Filter(q, xs))
        == Filter((x:T) => q(x) && p(x), xs) by
    {
      calc
      {
        Filter(p, Filter(q, xs));
          // Replace xs by Nil
        == Filter(p, Filter(q, Nil));
          // Unfold the inner Filter
        == Filter(p, Nil);
          // Unfold the outer Filter
        == Nil;
          // Fold Filter(x => q(x) && p(x), Nil)
        == Filter((x:T) => q(x) && p(x), Nil);
          // Replace Nil by xs
        == Filter((x:T) => q(x) && p(x), xs);
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
      //   Filter(p, Filter(q, tail)) = Filter(x => q(x) && p(x), tail)
    FilterComposition(p, q, tail);

    if q(x)
    {
      if p(x)
      {
        calc
        {
          Filter(p, Filter(q, xs));
            // Replace xs by Cons(x, tail)
          == Filter(p, Filter(q, Cons(x, tail)));
            // Since q(x) holds, the inner Filter retains x
          == Filter(p, Cons(x, Filter(q, tail)));
            // Since p(x) also holds, the outer Filter retains x
          == Cons(x, Filter(p, Filter(q, tail)));
            // Apply the induction hypothesis
          == Cons(x, Filter((y:T) => q(y) && p(y), tail));
            // Fold the combined Filter
          == Filter((y:T) => q(y) && p(y), Cons(x, tail));
            // Replace Cons(x, tail) by xs
          == Filter((y:T) => q(y) && p(y), xs);
        }
      }

      else
      {
        calc
        {
          Filter(p, Filter(q, xs));
            // Replace xs by Cons(x, tail)
          == Filter(p, Filter(q, Cons(x, tail)));
            // Since q(x) holds, the inner Filter retains x
          == Filter(p, Cons(x, Filter(q, tail)));
            // Since p(x) does not hold, the outer Filter discards x
          == Filter(p, Filter(q, tail));
            // Apply the induction hypothesis
          == Filter((y:T) => q(y) && p(y), tail);
            // Fold the combined Filter
          == Filter((y:T) => q(y) && p(y), Cons(x, tail));
            // Replace Cons(x, tail) by xs
          == Filter((y:T) => q(y) && p(y), xs);
        }
      }
    }

    else
    {
      calc
      {
        Filter(p, Filter(q, xs));
          // Replace xs by Cons(x, tail)
        == Filter(p, Filter(q, Cons(x, tail)));
          // Since q(x) does not hold, the inner Filter discards x
        == Filter(p, Filter(q, tail));
          // Apply the induction hypothesis
        == Filter((y:T) => q(y) && p(y), tail);
          // Fold the combined Filter
        == Filter((y:T) => q(y) && p(y), Cons(x, tail));
          // Replace Cons(x, tail) by xs
        == Filter((y:T) => q(y) && p(y), xs);
      }
    }
  }
}
