/*  file: Streams.dfy
    author: David De Potter
    description: definition of infinite streams and some basic
      operations
*/

module Streams
{
  //======================================================================
  // Represents an infinite stream. Every stream has a head element and
  // an infinite tail; there is deliberately no empty constructor.
  codatatype Stream<T> = Next(head:T, tail:Stream<T>)

  //======================================================================
  // Produces the infinite constant stream x, x, x, ... . The corecursive
  // call is guarded by Next, so every observation produces an element.
  function Repeat<T>(x:T): Stream<T>
  {
    Next(x, Repeat(x))
  }

  //======================================================================
  // Produces the infinite stream n, n+1, n+2, ... .
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
