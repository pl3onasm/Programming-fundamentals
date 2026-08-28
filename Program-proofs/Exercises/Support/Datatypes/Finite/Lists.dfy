/*  file: Lists.dfy
    author: David De Potter
    description: definition of generic linked lists and some basic
      operations
*/

include "../../Math.dfy"

module Lists
{
  import opened MathSupport

  //======================================================================
  // Represents a generic linked list. A list is either empty, represented
  // by the constructor Nil, or consists of a head element x and a tail
  // list xs, represented by the constructor Cons(x, xs). For example, the 
  // integer list [1,2,3] is represented by: 
  //   Cons(1, Cons(2, Cons(3, Nil))).
  datatype List<T> = Nil
                   | Cons(head:T, tail:List<T>)

  //======================================================================
  // Computes the number of elements in a list by recursing on the outer 
  // constructor until the empty list is reached, which has length 0:
  //   Length(Nil)          = 0
  //   Length(Cons(x, xs))  = 1 + Length(xs)
  function Length<T>(xs:List<T>): nat
    decreases xs
  {
    match xs
    case  Nil           => 0
    case  Cons(_, tail) => 1 + Length(tail)
  }

  //======================================================================
  // Concatenates two lists. The function recursively removes the outer
  // constructors of the first list and rebuilds them in front of the
  // second list:
  //   Append(Nil, ys)          = ys
  //   Append(Cons(x, xs), ys)  = Cons(x, Append(xs, ys))
  function Append<T>(xs:List<T>, ys:List<T>): List<T>
    decreases xs
  {
    match xs
    case  Nil           => ys
    case  Cons(x, tail) => Cons(x, Append(tail, ys))
  }

  //======================================================================
  // Reverses a list by recursively peeling off the head element and 
  // appending it as a singleton list to the reversed tail:
  //   Reverse(Nil)          = Nil
  //   Reverse(Cons(x, xs))  = Append(Reverse(xs), Cons(x, Nil))
  function Reverse<T>(xs:List<T>): List<T>
    decreases xs
  {
    match xs
    case  Nil           => Nil
    case  Cons(x, tail) => Append(Reverse(tail), Cons(x, Nil))
  }

  //======================================================================
  // Applies a function f to every element of a list while preserving its
  // structure. The output type (U) of f is allowed to differ from the 
  // input type (T) of f, so that the output list may contain elements of  
  // a different type than the input list.
  //   Map(f, Nil)          = Nil
  //   Map(f, Cons(x, xs))  = Cons(f(x), Map(f, xs))
  function Map<T,U>(f:T -> U, xs:List<T>): List<U>
    decreases xs
  {
    match xs
    case  Nil           => Nil
    case  Cons(x, tail) => Cons(f(x), Map(f, tail))
  }

  //======================================================================
  // Counts how many times a given value occurs in a list. The type
  // characteristic T(==) indicates that the type T is required to support
  // equality comparison, i.e. an == operator is defined for values of
  // type T.
  //   Count(x, Nil)          = 0
  //   Count(x, Cons(y, ys))  = ord(x = y) + Count(x, ys)
  function Count<T(==)>(x:T, xs:List<T>): nat
    decreases xs
  {
    match xs
    case  Nil           => 0
    case  Cons(y, tail) => ord(x == y) + Count(x, tail)
  }

  //======================================================================
  // Retains exactly those elements of a list that satisfy predicate p,
  // while preserving their original order:
  //   Filter(p, Nil)          = Nil
  //   Filter(p, Cons(x, xs))  = Cons(x, Filter(p, xs)), if p(x)
  //                             Filter(p, xs), otherwise
  function Filter<T>(p:T -> bool, xs:List<T>): List<T>
    decreases xs
  {
    match xs
    case  Nil           => Nil
    case  Cons(x, tail) => if p(x) then Cons(x, Filter(p, tail))
                                   else Filter(p, tail)
  }

}