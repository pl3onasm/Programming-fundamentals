/*  file: prob16.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob16
*/

include "../../Support/Datatypes/Lists.dfy"
import opened Lists

//========================================================================
// States that Nil is a right identity for Append. This standard property
// is assumed in this exercise to keep the proof focused on ReverseAppend.
// It can itself be proved by structural induction on xs.
lemma AppendRightIdentity<T>(xs:List<T>)
  ensures Append(xs, Nil) == xs
{
  assume {:axiom} Append(xs, Nil) == xs;
}

//========================================================================
// States that Append is associative. This standard property is assumed
// in this exercise to keep the proof focused on ReverseAppend.
// It can itself be proved by structural induction on xs.
lemma AppendAssociative<T>(xs:List<T>, ys:List<T>, zs:List<T>)
  ensures Append(Append(xs, ys), zs) == Append(xs, Append(ys, zs))
{
  assume {:axiom}
    Append(Append(xs, ys), zs) == Append(xs, Append(ys, zs));
}

//========================================================================
// Proves that reversing two appended lists reverses their order:
//   Reverse(Append(xs, ys)) = Append(Reverse(ys), Reverse(xs))
lemma {:induction false} ReverseAppend<T>(xs:List<T>, ys:List<T>)
  ensures Reverse(Append(xs, ys)) == Append(Reverse(ys), Reverse(xs))
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs.

      Base case, Q(Nil):
      
        Show that     Reverse(Append(Nil, ys))
                      = Append(Reverse(ys), Reverse(Nil))

      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):

        Assume that   Reverse(Append(tail, ys))
                      = Append(Reverse(ys), Reverse(tail))

        Prove that    Reverse(Append(Cons(x, tail), ys))
                      = Append(Reverse(ys), Reverse(Cons(x, tail)))

    Use the right-identity property in the base case and associativity 
    in the inductive case.

  */
}