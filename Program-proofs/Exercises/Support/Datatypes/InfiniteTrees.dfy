/*  file: InfiniteTrees.dfy
    author: David De Potter
    description: definition of infinite binary trees and some basic
      operations
*/

module InfiniteTrees
{
  //======================================================================
  // Represents an infinite binary tree. Every node contains a value and
  // two infinite subtrees; there is deliberately no empty constructor.
  codatatype ITree<T> = INode(
    left:ITree<T>, value:T, right:ITree<T>)

  //======================================================================
  // Produces the infinite tree in which every node contains x.
  function ConstantTree<T>(x:T): ITree<T>
  {
    INode(ConstantTree(x), x, ConstantTree(x))
  }

  //======================================================================
  // Applies f to the value stored at every node of an infinite tree.
  function Map<A, B>(f:A -> B, tree:ITree<A>): ITree<B>
  {
    INode(Map(f, tree.left), f(tree.value), Map(f, tree.right))
  }

  //======================================================================
  // Mirrors an infinite tree by recursively exchanging its subtrees.
  function Mirror<T>(tree:ITree<T>): ITree<T>
  {
    INode(Mirror(tree.right), tree.value, Mirror(tree.left))
  }

  //======================================================================
  // Returns the finite sequence of values at depth n, from left to
  // right. The root is at depth 0.
  function Level<T>(tree:ITree<T>, n:nat): seq<T>
    decreases n
  {
    if n == 0 then [tree.value]
              else Level(tree.left, n-1) + Level(tree.right, n-1)
  }

  //======================================================================
  // Holds when predicate p is satisfied by every node value in tree.
  greatest predicate All<T>(p:T -> bool, tree:ITree<T>)
  {
    p(tree.value) && All(p, tree.left) && All(p, tree.right)
  }
}
