/*  file: prob15.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob15
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// Proves that mapping a function over two appended lists is equivalent
// to mapping the function over each list separately and then appending
// the results:  Map(f, Append(xs, ys)) = Append(Map(f, xs), Map(f, ys))
lemma {:induction false} MapAppend<T, U>(f:T -> U, xs:List<T>, ys:List<T>)
  ensures Map(f, Append(xs, ys)) == Append(Map(f, xs), Map(f, ys))
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q(Nil):
        Show that
          Map(f, Append(Nil, ys))
          = Append(Map(f, Nil), Map(f, ys))
   
      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):
        Assume that
          Map(f, Append(tail, ys))
          = Append(Map(f, tail), Map(f, ys))
        and prove that
          Map(f, Append(Cons(x, tail), ys))
          = Append(Map(f, Cons(x, tail)), Map(f, ys))
  */
}
