/*  file: InfiniteLists.dfy
    author: David De Potter
    description: definition of possibly infinite lists and some basic
      operations

    NOTE:
    An ordinary datatype represents only finite values. Every value must
    be built completely using a finite number of constructor applications.
    For example, a value of datatype List<T> must eventually end in Nil.

    A codatatype may also represent an infinite value. Its constructors
    are evaluated lazily: constructing a value does not require Dafny to
    construct the entire value immediately. Instead, the next part is
    produced only when it is observed, for example by accessing its head
    or tail. At any particular moment, only a finite portion of the
    potentially infinite structure needs to be evaluated.

    Infinite codatatype values are commonly constructed by corecursive
    functions. Whereas an ordinary recursive function consumes a finite
    value by repeatedly removing constructors until it reaches a base
    case, a corecursive function produces a potentially infinite value
    one constructor at a time. Its recursive call describes the remainder
    of the value and is placed inside a codatatype constructor. The outer
    constructor can therefore be produced immediately, while the recursive
    call is evaluated only when the remainder is observed.

    A corecursive definition need not have a base case. For example, a
    function defining an infinite stream can produce its head immediately
    and use a corecursive call to describe its tail.

    This combination of codatatypes, laziness, and corecursion makes it
    possible to define streams, infinite lists, and infinite trees.

    A codatatype is not necessarily infinite. If it has a terminating
    constructor such as Nil, it may represent both finite and infinite
    values. A stream with only a constructor containing a head and a tail,
    however, is necessarily infinite.
*/

module InfiniteLists
{
  //======================================================================
  // Represents a possibly infinite list. iNil terminates a finite list,
  // while an infinite sequence of iCons constructors represents an
  // infinite list.
  codatatype iList<T> = iNil
                      | iCons(head:T, tail:iList<T>)

  //======================================================================
  // Applies f to every element of a possibly infinite list.
  function Map<A, B>(f:A -> B, xs:iList<A>): iList<B>
  {
    match xs
    case iNil           => iNil
    case iCons(x, tail) => iCons(f(x), Map(f, tail))
  }

  //======================================================================
  // Appends ys after xs. If xs is infinite, every finite observation of
  // the result lies inside xs, so ys is never reached.
  function Append<T>(xs:iList<T>, ys:iList<T>): iList<T>
  {
    match xs
    case iNil           => ys
    case iCons(x, tail) => iCons(x, Append(tail, ys))
  }

  //======================================================================
  // Holds exactly when xs reaches iNil after finitely many iCons
  // constructors. As a least predicate, IsFinite requires a finite
  // derivation ending in the iNil case.
  least predicate IsFinite<T>(xs:iList<T>)
  {
    xs.iNil? || (xs.iCons? && IsFinite(xs.tail))
  }

  //======================================================================
  // Holds exactly when xs continues with iCons constructors forever and
  // therefore never reaches iNil. As a greatest predicate, IsInfinite
  // permits the recursive condition to continue indefinitely.
  greatest predicate IsInfinite<T>(xs:iList<T>)
  {
    xs.iCons? && IsInfinite(xs.tail)
  }
}
