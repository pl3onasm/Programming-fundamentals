/*  file: prob18.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob18
    
    NOTE:
    In this problem, we want to examine a more efficient implementation 
    of the Reverse function. The issue with the original Reverse function
    is that it uses Append to add each element to the end of the reversed
    list. This means that in each recursive call, the entire reversed tail
    must first be traversed to reach the end of the list before the head
    element can be added. For a list of length n, these traversals have
    lengths 0, 1, ..., n-1. The sum of these traversal lengths is 
    therefore proportional to n², resulting in a quadratic-time 
    implementation of Reverse.
    The more efficient implementation, called FastReverse, uses an
    initially empty accumulator list to collect the partial result. Each
    recursive step removes one element from the front of the input list
    and prepends it to the accumulator by wrapping the element and the
    accumulator in a new Cons constructor. This takes constant time,
    because the accumulator itself does not need to be traversed. Since
    each element is moved to the accumulator exactly once, the overall
    time complexity is linear in the length of the input list.
    In order to prove the correctness of FastReverse, we will first prove
    a more general property of the accumulator-based implementation,
    called ReverseAcc, which reverses a list in front of an arbitrary
    accumulator list. The property states that the result of ReverseAcc
    is the same as appending the reversed input list to the accumulator
    list. Proving this more general property is necessary because the 
    recursive call in ReverseAcc uses the non-empty accumulator 
    Cons(x, acc). A statement concerning only the initially empty 
    accumulator would therefore be too weak to serve as the induction 
    hypothesis. Once this property is established, the correctness of 
    FastReverse follows by choosing the empty list as the accumulator.
*/

include "../prob16/sol16.dfy"

//========================================================================
// Reverses a list by recursively removing each head element from the 
// input list and prepending it to an accumulator list, which may be 
// non-empty. Once the input list is exhausted, the accumulator list is 
// returned as the result. 
//   ReverseAcc(Nil, acc)         = acc
//   ReverseAcc(Cons(x, xs), acc) = ReverseAcc(xs, Cons(x, acc))
function ReverseAcc<T>(xs:List<T>, acc:List<T>): List<T>
  decreases xs
{
  match xs
  case  Nil           => acc
  case  Cons(x, tail) => ReverseAcc(tail, Cons(x, acc))
}

//========================================================================
// A wrapper for ReverseAcc that starts the accumulator with the empty 
// list.
function FastReverse<T>(xs:List<T>): List<T>
{
  ReverseAcc(xs, Nil)
}

//========================================================================
// Proves the property that the result of ReverseAcc is the same as 
// appending the reversed list to the accumulator list:
//   ReverseAcc(xs, acc) = Append(Reverse(xs), acc)
lemma {:induction false} ReverseAccProp<T>(xs:List<T>, acc:List<T>)
  ensures   ReverseAcc(xs, acc) == Append(Reverse(xs), acc)
  decreases xs
{
  /*
    Prove this lemma by structural induction on xs, distinguishing the
    cases xs = Nil and xs = Cons(x, tail).

      Base case, Q(Nil):
        Show that ReverseAcc(Nil, acc) = Append(Reverse(Nil), acc)

      Inductive case, Q(tail) ⇒ Q(Cons(x, tail)):
        Assume that the property holds for tail:
          ReverseAcc(tail, Cons(x, acc))
          = Append(Reverse(tail), Cons(x, acc))
        Then prove that it holds for Cons(x, tail):
          ReverseAcc(Cons(x, tail), acc)
          = Append(Reverse(Cons(x, tail)), acc)

    Use AppendAssociative that was given in the solution to problem16.
  */
}

//========================================================================
// Proves that the accumulator-based implementation computes exactly the 
// same result as Reverse:  FastReverse(xs) = Reverse(xs)
lemma FastReverseCorrect<T>(xs:List<T>)
  ensures FastReverse(xs) == Reverse(xs)
{
  /*
    Apply ReverseAccProp with acc = Nil, and then use
    AppendRightIdentity that was given in the solution to problem16.
  */
}
