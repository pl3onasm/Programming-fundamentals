/*  file: prob19.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob19
*/

include "../../Support/Datatypes/Finite/Lists.dfy"
import opened Lists

//========================================================================
// Proves that mapping f over a list and then filtering the resulting
// values with p is equivalent to first retaining exactly those original
// values x for which p(f(x)) holds, and then mapping f over them:
//
//   Filter(p, Map(f, xs)) = Map(f, Filter(x => p(f(x)), xs))
//
// The lambda expression (x:A) => p(f(x)) defines a predicate on the
// original element type A. It holds for an element x exactly when its
// mapped value f(x) satisfies the predicate p on the element type B.
lemma {:induction false} MapFilter<A,B>(f:A -> B, p:B -> bool, xs:List<A>)
  ensures Filter(p, Map(f, xs)) == Map(f, Filter((x:A) => p(f(x)), xs))
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

    Base case, Q(Nil):

      Show that     Filter(p, Map(f, Nil))
                    = Map(f, Filter(x => p(f(x)), Nil))

    Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):
    
      Assume that   Filter(p, Map(f, tail))
                    = Map(f, Filter(x => p(f(x)), tail))

      Prove that    Filter(p, Map(f, Cons(x, tail)))
                    = Map(f, Filter(x => p(f(x)), Cons(x, tail)))

    In the inductive case, distinguish whether p(f(x)) holds. If it
    does, both sides retain the mapped head f(x). Otherwise, both 
    sides discard it.
  */
}
