/*  file: prob21.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob21
*/

include "../../Support/Datatypes/BinaryTrees.dfy"
import opened BinaryTrees

//========================================================================
// Proves that the length of the inorder traversal of a binary tree equals
// the number of nodes in the tree:  |Inorder(tree)| = Size(tree)
lemma {:induction false} InorderLength<T>(tree:BinTree<T>)
  ensures |Inorder(tree)| == Size(tree)
  decreases tree
{
  /*
    Prove this lemma by structural induction on tree.

      Base case, Q(Empty):
        Show that     |Inorder(Empty)| = Size(Empty)

      Inductive case, Q(left) ∧ Q(right) ⇒ Q(Node(left, x, right)):
        Assume that   |Inorder(left) | = Size(left)
                      |Inorder(right)| = Size(right)

        Prove that    |Inorder(Node(left, x, right))|
                      = Size(Node(left, x, right))

    Distinguish between the base case and the inductive case by testing
    whether tree is Empty or not. In the inductive case, the induction 
    hypothesis applies to both structurally smaller subtrees, left and 
    right, and is used to prove the equality for the larger tree, which
    wraps the two subtrees in a new root node, Node(left, x, right).
    You may want to use the following property of the length of a 
    concatenation of sequences:
          |s1 + s2| = |s1| + |s2|
    Dafny knows about this property, so you can use it without having 
    to prove it.
  */
}