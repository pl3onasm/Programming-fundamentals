/*  file: prob25.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob25
*/

include "../../Support/Datatypes/BinaryTrees.dfy"
include "../prob05/sol05.dfy"

import opened BinaryTrees

//========================================================================
// Proves that the inorder traversal of a mirrored binary tree is the
// reverse of the inorder traversal of the original tree:
//   Inorder(Mirror(tree)) = Reverse(Inorder(tree))
lemma {:induction false} InorderMirror(tree:BinTree<int>)
  ensures Inorder(Mirror(tree)) == Reverse(Inorder(tree))
  decreases tree
{
  /*
    Prove this lemma by structural induction on tree.

    Base case, Q(Empty):
      Show that     Inorder(Mirror(Empty)) = Reverse(Inorder(Empty))

    Inductive case, Q(left) ∧ Q(right) ⇒ Q(Node(left, x, right)):

      Assume that   Inorder(Mirror(left))  = Reverse(Inorder(left))
                    Inorder(Mirror(right)) = Reverse(Inorder(right))
                    
      prove that    Inorder(Mirror(Node(left, x, right)))
                    = Reverse(Inorder(Node(left, x, right)))

    The sequence function Reverse and the lemma ReverseConcat are
    imported from the solution to problem05. In the inductive case, 
    use ReverseConcat twice in reverse direction.
  */
}
