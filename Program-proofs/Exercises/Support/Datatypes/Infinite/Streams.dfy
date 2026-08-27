/*  file: Streams.dfy
    author: David De Potter
    description: definition of infinite streams and some basic
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

module Streams
{
  //======================================================================
  // Represents an infinite stream. Every stream has a head element and
  // an infinite tail. There is deliberately no empty constructor.
  codatatype Stream<T> = Next(head:T, tail:Stream<T>)

  //======================================================================
  // Produces the infinite constant stream x, x, x, ... . The corecursive
  // call is guarded by Next, so every observation produces an element.
  function Repeat<T>(x:T): Stream<T>
  {
    Next(x, Repeat(x))
  }

  //======================================================================
  // Produces the infinite stream n, n+1, n+2, ... . Hence From(0) 
  // produces the stream of all natural numbers starting from 0.
  function From(n:int): Stream<int>
  {
    Next(n, From(n+1))
  }

  //======================================================================
  // Produces the infinite stream obtained by repeatedly applying f:
  //   x, f(x), f(f(x)), ...
  function Iterate<T>(f:T -> T, x:T): Stream<T>
  {
    Next(x, Iterate(f, f(x)))
  }

  //======================================================================
  // Applies f to every element of an infinite stream.
  function Map<A, B>(f:A -> B, stream:Stream<A>): Stream<B>
  {
    Next(f(stream.head), Map(f, stream.tail))
  }

  //======================================================================
  // Zips two streams together. The resulting stream contains pairs of
  // corresponding elements from the left and right streams.
  function Zip<A, B>(left:Stream<A>, right:Stream<B>): Stream<(A, B)>
  {
    Next((left.head, right.head), Zip(left.tail, right.tail))
  }

  //======================================================================
  // Combines corresponding elements of two infinite streams using f.
  function ZipWith<A,B,C>(f:(A, B) -> C, left:Stream<A>, 
                          right:Stream<B>): Stream<C>
  {
    Next(f(left.head, right.head), ZipWith(f, left.tail, right.tail))
  }

  //======================================================================
  // Alternates elements from two streams:
  //   left[0], right[0], left[1], right[1], ...
  function Interleave<T>(left:Stream<T>, right:Stream<T>): Stream<T>
  {
    Next(left.head, Interleave(right, left.tail))
  }

  //======================================================================
  // Retains the elements at even positions 0, 2, 4, ... .
  function Even<T>(stream:Stream<T>): Stream<T>
  {
    Next(stream.head, Even(stream.tail.tail))
  }

  //======================================================================
  // Retains the elements at odd positions 1, 3, 5, ... .
  function Odd<T>(stream:Stream<T>): Stream<T>
  {
    Next(stream.tail.head, Odd(stream.tail.tail))
  }

  //======================================================================
  // Returns the element at the zero-based position n of a stream.
  function Nth<T>(stream:Stream<T>, n:nat): T
    decreases n
  {
    if n == 0 then stream.head
              else Nth(stream.tail, n-1)
  }

  //======================================================================
  // Returns the first n elements of a stream as a finite sequence.
  function Take<T>(stream:Stream<T>, n:nat): seq<T>
    decreases n
  {
    if n == 0 then []
              else [stream.head] + Take(stream.tail, n-1)
  }

  //======================================================================
  // Drops the first n elements of a stream and returns the remainder.
  function Drop<T>(stream:Stream<T>, n:nat): Stream<T>
  {
    if n == 0 then stream
              else Drop(stream.tail, n-1)
  }

  //======================================================================
  // Produces the generalized Fibonacci stream beginning with a and b:
  //   a, b, a+b, a+2b, ...
  function FibFrom(a:int, b:int): Stream<int>
  {
    Next(a, FibFrom(b, a + b))
  }

  //======================================================================
  // Produces the infinite stream of Fibonacci numbers:
  //   0, 1, 1, 2, 3, 5, 8, 13, ...
  function Fib(): Stream<int>
  {
    FibFrom(0, 1)
  }
}
