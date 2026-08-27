/*  file: prob23.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob23
*/

include "../../Support/Datatypes/Finite/BinaryTrees.dfy"
import opened BinaryTrees

//========================================================================
// Proves that mirroring a binary tree twice returns the original tree:
//   Mirror(Mirror(tree)) = tree
lemma {:induction false} MirrorTwice<T>(tree:BinTree<T>)
  ensures Mirror(Mirror(tree)) == tree
  decreases tree
{
  /*
    Prove this lemma by structural induction on tree.

      Base case, Q(Empty):
        Show that     Mirror(Mirror(Empty)) = Empty

      Inductive case, Q(left) ∧ Q(right) ⇒ Q(Node(left, x, right)):

        Assume that   Mirror(Mirror(left))  = left
                      Mirror(Mirror(right)) = right

        Prove that    Mirror(Mirror(Node(left, x, right)))
                      = Node(left, x, right)

    In the inductive case, apply the lemma recursively to both
    structurally smaller subtrees.
  */
}