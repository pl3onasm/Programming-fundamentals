/*  file: BinaryTrees.dfy
    author: David De Potter
    description: definition of generic binary trees and some basic
      structural and traversal operations
*/

include "../../Math.dfy"

module BinaryTrees
{
  import opened MathSupport

  //======================================================================
  // Represents a generic binary tree. A binary tree is either empty, or
  // consists of a value together with a left and a right subtree.
  // For example, the tree
  //
  //          2
  //         / \
  //        1   3
  //       / \ / \
  //      E  E E  E
  //
  // where E denotes Empty, is represented by: 
  //   Node(Node(Empty,1,Empty),2,Node(Empty,3,Empty))
  datatype BinTree<T> = Empty
                      | Node(left:BinTree<T>, value:T, right:BinTree<T>)

  //======================================================================
  // Computes the size of a binary tree by counting the node constructors 
  // recursively. The empty tree has size 0, while a nonempty tree has 
  // size one greater than the sum of the sizes of its two subtrees:
  //  Size(Empty)         = 0
  //  Size(Node(l, x, r)) = 1 + Size(l) + Size(r)
  function Size<T>(tree:BinTree<T>): nat
    decreases tree
  {
    match tree
    case  Empty         => 0
    case  Node(l, _, r) => 1 + Size(l) + Size(r)
  }

  //======================================================================
  // Computes the height of a binary tree. The empty tree has height 0,
  // while a nonempty tree has height one greater than the larger height
  // of its two subtrees:
  //  Height(Empty)                = 0
  //  Height(Node(left, x, right)) = 1 + max(Height(left), Height(right))
  function Height<T>(tree:BinTree<T>): nat
    decreases tree
  {
    match tree
    case  Empty         => 0
    case  Node(l, _, r) => 1 + maximum(Height(l), Height(r))
  }

  //======================================================================
  // Returns the inorder traversal of a binary tree. The left subtree is
  // traversed first, followed by the root and then the right subtree:
  //  Inorder(Empty)         = []
  //  Inorder(Node(l, x, r)) = Inorder(l) + [x] + Inorder(r)
  // The result is an immutable sequence containing the values in the
  // order in which they were visited during the traversal.
  function Inorder<T>(tree:BinTree<T>): seq<T>
    decreases tree
  {
    match tree
    case  Empty         => []
    case  Node(l, x, r) => Inorder(l) + [x] + Inorder(r)
  }

  //======================================================================
  // Returns the preorder traversal of a binary tree. The root is visited
  // first, followed by the left and right subtrees:
  //  Preorder(Empty)         = []
  //  Preorder(Node(l, x, r)) = [x] + Preorder(l) + Preorder(r)
  // The result is an immutable sequence containing the values in the
  // order in which they were visited during the traversal.
  function Preorder<T>(tree:BinTree<T>): seq<T>
    decreases tree
  {
    match tree
    case  Empty         => []
    case  Node(l, x, r) => [x] + Preorder(l) + Preorder(r)
  }

  //======================================================================
  // Returns the postorder traversal of a binary tree. The left and right
  // subtrees are traversed first, after which the root is visited:
  //  Postorder(Empty)         = []
  //  Postorder(Node(l, x, r)) = Postorder(l) + Postorder(r) + [x]
  // The result is an immutable sequence containing the values in the
  // order in which they were visited during the traversal.
  function Postorder<T>(tree:BinTree<T>): seq<T>
    decreases tree
  {
    match tree
    case  Empty         => []
    case  Node(l, x, r) => Postorder(l) + Postorder(r) + [x]
  }

  //======================================================================
  // Mirrors a binary tree by recursively exchanging its left and right
  // subtrees:
  //  Mirror(Empty)         = Empty
  //  Mirror(Node(l, x, r)) = Node(Mirror(r), x, Mirror(l))
  function Mirror<T>(tree:BinTree<T>): BinTree<T>
    decreases tree
  {
    match tree
    case  Empty         => Empty
    case  Node(l, x, r) => Node(Mirror(r), x, Mirror(l))
  }

  //======================================================================
  // Applies a function f to every value in a binary tree while preserving
  // its structure. The output type U may differ from the input type T:
  //  MapTree(f, Empty)         = Empty
  //  MapTree(f, Node(l, x, r)) = Node(MapTree(f, l), f(x), MapTree(f, r))
  function MapTree<T, U>(f:T -> U, tree:BinTree<T>): BinTree<U>
    decreases tree
  {
    match tree
    case  Empty         => Empty
    case  Node(l, x, r) => Node(MapTree(f, l), f(x), MapTree(f, r))
  }

}