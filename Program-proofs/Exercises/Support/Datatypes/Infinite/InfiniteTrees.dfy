/*  file: InfiniteTrees.dfy
    author: David De Potter
    description: definition of infinite binary trees and some basic
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

module InfiniteTrees
{
  //======================================================================
  // Represents an infinite binary tree. Every node contains a value and
  // two infinite subtrees. There is deliberately no empty constructor.
  codatatype iTree<T> = iNode(left:iTree<T>, value:T, right:iTree<T>)

  //======================================================================
  // Produces the infinite tree in which every node contains x.
  function ConstantTree<T>(x:T): iTree<T>
  {
    iNode(ConstantTree(x), x, ConstantTree(x))
  }

  //======================================================================
  // Applies f to the value stored at every node of an infinite tree.
  function Map<A, B>(f:A -> B, tree:iTree<A>): iTree<B>
  {
    iNode(Map(f, tree.left), f(tree.value), Map(f, tree.right))
  }

  //======================================================================
  // Mirrors an infinite tree by recursively exchanging its subtrees.
  function Mirror<T>(tree:iTree<T>): iTree<T>
  {
    iNode(Mirror(tree.right), tree.value, Mirror(tree.left))
  }

  //======================================================================
  // Returns the finite sequence of values at depth n, from left to
  // right. The root is at depth 0.
  function Level<T>(tree:iTree<T>, n:nat): seq<T>
    decreases n
  {
    if n == 0 then [tree.value]
              else Level(tree.left, n-1) + Level(tree.right, n-1)
  }

  //======================================================================
  // Holds when predicate p is satisfied by every node value in tree.
  greatest predicate All<T>(p:T -> bool, tree:iTree<T>)
  {
    p(tree.value) && All(p, tree.left) && All(p, tree.right)
  }
}
