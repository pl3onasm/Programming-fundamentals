/*  file: sol19.dfy
    author: David De Potter
    description: proof by structural induction that filtering after 
    mapping is equivalent to first filtering the original values 
    according to whether their mapped values satisfy p, and then 
    mapping them
*/

include "../../Support/Datatypes/Finite/Lists.dfy"
import opened Lists

//========================================================================
// Proves that mapping f over a list and then filtering the resulting
// values with p is equivalent to first retaining exactly those original
// values x for which p(f(x)) holds, and then mapping f over them:
//   Filter(p, Map(f, xs)) = Map(f, Filter(x => p(f(x)), xs))
lemma {:induction false} MapFilter<A,B>(f:A -> B, p:B -> bool, xs:List<A>)
  ensures Filter(p, Map(f, xs)) == Map(f, Filter((x:A) => p(f(x)), xs))
  decreases xs
{
  if xs == Nil
  {
      // Base case: Q(Nil) is true
    assert Filter(p, Map(f, xs))
        == Map(f, Filter((x:A) => p(f(x)), xs)) by
    {
      calc
      {
        Filter(p, Map(f, xs));
          // Replace xs by Nil
        == Filter(p, Map(f, Nil));
          // Unfold Map
        == Filter(p, Nil);
          // Unfold Filter
        == Nil;
          // Fold Map
        == Map(f, Nil);
          // Fold Filter
        == Map(f, Filter((x:A) => p(f(x)), Nil));
          // Replace Nil by xs
        == Map(f, Filter((x:A) => p(f(x)), xs));
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
      //   Filter(p, Map(f, tail)) = Map(f, Filter(x => p(f(x)), tail))
    MapFilter(f, p, tail);

    if p(f(x))
    {
      calc
      {
        Filter(p, Map(f, xs));
          // Replace xs by Cons(x, tail)
        == Filter(p, Map(f, Cons(x, tail)));
          // Unfold Map
        == Filter(p, Cons(f(x), Map(f, tail)));
          // Since p(f(x)) holds, Filter retains f(x)
        == Cons(f(x), Filter(p, Map(f, tail)));
          // Apply the induction hypothesis
        == Cons(f(x), Map(f, Filter((y:A) => p(f(y)), tail)));
          // Fold Map
        == Map(f, Cons(x, Filter((y:A) => p(f(y)), tail)));
          // Since p(f(x)) holds, fold Filter on Cons(x, tail)
        == Map(f, Filter((y:A) => p(f(y)), Cons(x, tail)));
          // Replace Cons(x, tail) by xs
        == Map(f, Filter((y:A) => p(f(y)), xs));
      }
    }

    else
    {
      calc
      {
        Filter(p, Map(f, xs));
          // Replace xs by Cons(x, tail)
        == Filter(p, Map(f, Cons(x, tail)));
          // Unfold Map
        == Filter(p, Cons(f(x), Map(f, tail)));
          // Since p(f(x)) does not hold, Filter discards f(x)
        == Filter(p, Map(f, tail));
          // Apply the induction hypothesis
        == Map(f, Filter((y:A) => p(f(y)), tail));
          // Since p(f(x)) does not hold, fold Filter on Cons(x, tail)
        == Map(f, Filter((y:A) => p(f(y)), Cons(x, tail)));
          // Replace Cons(x, tail) by xs
        == Map(f, Filter((y:A) => p(f(y)), xs));
      }
    }
  }
}
