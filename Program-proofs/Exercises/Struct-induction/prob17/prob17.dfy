/*  file: prob17.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob17
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// States that the number of occurrences of z in two appended lists is
// the sum of its occurrence counts in the separate lists:
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
// Proves that reversing a list does not change the number of occurrences
// of any value:  Count(z, Reverse(xs)) = Count(z, xs)
lemma {:induction false} CountReverse<T>(z:T, xs:List<T>)
  ensures Count(z, Reverse(xs)) == Count(z, xs)
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q(Nil):
      
        Show that     Count(z, Reverse(Nil)) = Count(z, Nil)

      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):
        
        Assume that   Count(z, Reverse(tail)) = Count(z, tail)
        
        Prove that    Count(z, Reverse(Cons(x, tail))) 
                      = Count(z, Cons(x, tail))
    
    In the inductive case, apply CountAppend to the definition of 
    Reverse(Cons(x, tail)).

  */
}
