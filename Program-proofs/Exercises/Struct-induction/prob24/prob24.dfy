/*  file: prob24.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob24
*/

include "../../Support/Datatypes/Finite/BinaryTrees.dfy"
include "../../Support/Math.dfy"

import opened BinaryTrees
import opened MathSupport

//========================================================================
// Proves that mapping g and then f over a binary tree is equivalent to
// mapping their composition once:
//   MapTree(f, MapTree(g, tree)) = MapTree(Compose(f, g), tree)
lemma {:induction false} MapTreeComposition<A, B, C>(
  f:B -> C, g:A -> B, tree:BinTree<A>)
  ensures MapTree(f, MapTree(g, tree))
       == MapTree(Compose(f, g), tree)
  decreases tree
{
  /*
    Prove this lemma by structural induction on tree.

      Base case, Q(Empty):
        Show that
          MapTree(f, MapTree(g, Empty)) = MapTree(Compose(f, g), Empty)

      Inductive case, Q(left) ∧ Q(right) ⇒ Q(Node(left, x, right)):
        
        Assume that

          MapTree(f, MapTree(g, left))  = MapTree(Compose(f, g), left)
          MapTree(f, MapTree(g, right)) = MapTree(Compose(f, g), right)
        
        and prove that
        
          MapTree(f, MapTree(g, Node(left, x, right)))
          = MapTree(Compose(f, g), Node(left, x, right))

    Recall that Compose(f, g)(x) = f(g(x)). In the inductive case,
    apply the lemma recursively to both structurally smaller subtrees.
  */
}