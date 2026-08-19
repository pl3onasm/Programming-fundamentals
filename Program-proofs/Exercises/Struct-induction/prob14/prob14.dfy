/*  file: prob14.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob14
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// Proves that mapping a function over a list preserves its length:
//   Length(Map(f, xs)) = Length(xs)
lemma {:induction false} LengthMap<T, U>(f:T -> U, xs:List<T>)
  ensures Length(Map(f, xs)) == Length(xs)
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q(Nil):
      
        Show that     Length(Map(f, Nil)) = Length(Nil)
    
      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):

        Assume that   Length(Map(f, tail)) = Length(tail)

        Prove that    Length(Map(f, Cons(x, tail))) 
                      = Length(Cons(x, tail))
    
  */
}
