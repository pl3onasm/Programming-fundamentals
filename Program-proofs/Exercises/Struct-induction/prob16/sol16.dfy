/*  file: sol16.dfy
    author: David De Potter
    description: proof by structural induction that reversing two
      appended lists reverses their order
*/

include "../../Support/Datatypes/Finite/Lists.dfy"
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
// Proves by structural induction on xs that reversing two appended lists
// reverses their order:
//   Reverse(Append(xs, ys)) = Append(Reverse(ys), Reverse(xs))
lemma {:induction false} ReverseAppend<T>(xs:List<T>, ys:List<T>)
  ensures Reverse(Append(xs, ys)) == Append(Reverse(ys), Reverse(xs))
  decreases xs
{
  if xs == Nil
  {
      // Use the assumed right-identity property of Append
     AppendRightIdentity(Reverse(ys));
      
      // Base case: Q(Nil) is true
    assert Reverse(Append(xs, ys)) == Append(Reverse(ys), Reverse(xs)) by
    {
      calc
      {
        Reverse(Append(xs, ys));
          // Replace xs by Nil
        == Reverse(Append(Nil, ys));
          // Unfold Append(Nil, ys)
        == Reverse(ys);
          // Apply AppendRightIdentity in reverse direction
        == Append(Reverse(ys), Nil);
          // Fold Reverse(Nil)
        == Append(Reverse(ys), Reverse(Nil));
          // Replace Nil by xs
        == Append(Reverse(ys), Reverse(xs));
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
      //   Reverse(Append(tail, ys)) = Append(Reverse(ys), Reverse(tail))
    ReverseAppend(tail, ys);

      // Use the assumed associativity of Append to regroup the lists
      // after applying the induction hypothesis
    AppendAssociative(Reverse(ys), Reverse(tail), Cons(x, Nil));

      // Inductive case
      // Prove Q(Cons(x, tail)) is true
    calc
    {
      Reverse(Append(xs, ys));
        // Replace xs by Cons(x, tail)
      == Reverse(Append(Cons(x, tail), ys));
        // Unfold Append on its first argument
      == Reverse(Cons(x, Append(tail, ys)));
        // Unfold Reverse
      == Append(Reverse(Append(tail, ys)), Cons(x, Nil));
        // Apply the induction hypothesis
      == Append(Append(Reverse(ys), Reverse(tail)), Cons(x, Nil));
        // Apply AppendAssociative
      == Append(Reverse(ys), Append(Reverse(tail), Cons(x, Nil)));
        // Fold Reverse(Cons(x, tail))
      == Append(Reverse(ys), Reverse(Cons(x, tail)));
        // Replace Cons(x, tail) by xs
      == Append(Reverse(ys), Reverse(xs));
    }
  }
}
