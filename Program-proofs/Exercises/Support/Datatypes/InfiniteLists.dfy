/*  file: InfiniteLists.dfy
    author: David De Potter
    description: definition of possibly infinite lists and some basic
      operations
*/

module InfiniteLists
{
  //======================================================================
  // Represents a possibly infinite list. INil terminates a finite list,
  // while an infinite sequence of ICons constructors represents an
  // infinite list.
  codatatype IList<T> = INil
                      | ICons(head:T, tail:IList<T>)

  //======================================================================
  // Applies f to every element of a possibly infinite list.
  function Map<A, B>(f:A -> B, xs:IList<A>): IList<B>
  {
    match xs
    case INil           => INil
    case ICons(x, tail) => ICons(f(x), Map(f, tail))
  }

  //======================================================================
  // Appends ys after xs. If xs is infinite, every finite observation of
  // the result lies inside xs, so ys is never reached.
  function Append<T>(xs:IList<T>, ys:IList<T>): IList<T>
  {
    match xs
    case INil           => ys
    case ICons(x, tail) => ICons(x, Append(tail, ys))
  }

  //======================================================================
  // Holds exactly when xs reaches INil after finitely many ICons
  // constructors. As a least predicate, IsFinite requires a finite
  // derivation ending in the INil case.
  least predicate IsFinite<T>(xs:IList<T>)
  {
    xs.INil? || (xs.ICons? && IsFinite(xs.tail))
  }

  //======================================================================
  // Holds exactly when xs continues with ICons constructors forever and
  // therefore never reaches INil. As a greatest predicate, IsInfinite
  // permits the recursive condition to continue indefinitely.
  greatest predicate IsInfinite<T>(xs:IList<T>)
  {
    xs.ICons? && IsInfinite(xs.tail)
  }
}
