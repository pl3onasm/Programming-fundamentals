/*  file: prob20.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob20
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// Proves that filtering a list first with q and then with p is equivalent
// to filtering it once with the combined predicate q(x) && p(x):
//   Filter(p, Filter(q, xs)) = Filter(x => q(x) && p(x), xs)
lemma {:induction false} FilterComposition<T>(p:T -> bool, q:T -> bool, 
                                              xs:List<T>)
  ensures Filter(p, Filter(q, xs)) == Filter((x:T) => q(x) && p(x), xs)
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q(Nil):
        Show that     Filter(p, Filter(q, Nil))
                      = Filter(x => q(x) && p(x), Nil)

      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):
      
        Assume that   Filter(p, Filter(q, tail))
                      = Filter(x => q(x) && p(x), tail)

        Prove that    Filter(p, Filter(q, Cons(x, tail)))
                      = Filter(x => q(x) && p(x), Cons(x, tail))

    In the inductive case, first distinguish whether q(x) holds. If it
    does, distinguish whether p(x) also holds. The head x is retained 
    by both sides exactly when both predicates hold.
  */
}
