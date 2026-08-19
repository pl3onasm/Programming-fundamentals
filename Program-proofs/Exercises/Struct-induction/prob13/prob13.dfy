/*  file: prob13.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob13
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// Proves that the length of two appended lists is the sum of their
// separate lengths:  Length(Append(xs, ys)) = Length(xs) + Length(ys)
lemma {:induction false} LengthAppend<T>(xs:List<T>, ys:List<T>)
  ensures Length(Append(xs, ys)) == Length(xs) + Length(ys)
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q(Nil):
      
        Show that     Length(Append(Nil, ys)) = Length(Nil) + Length(ys)
        
      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):
        
        Assume that   Length(Append(tail, ys)) = Length(tail) + Length(ys)
        
        Prove that    Length(Append(Cons(x, tail), ys))
                      = Length(Cons(x, tail)) + Length(ys)
    
    Distinguish the two structural cases by testing whether xs = Nil.
    Otherwise, xs has the form Cons(xs.head, xs.tail), where xs.tail is
    the structurally smaller list to which the induction hypothesis
    applies.
    
  */
}
