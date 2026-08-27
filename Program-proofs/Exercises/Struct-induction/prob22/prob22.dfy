/*  file: prob22.dfy
    author: your name
    description: extra practice in Dafny, structural induction,
    prob22
*/

include "../../Support/Datatypes/Finite/BinaryTrees.dfy"
include "../../Support/Math.dfy"

import opened BinaryTrees
import opened MathSupport

//========================================================================
// Proves that the height of a binary tree is at most its size:
//   Height(tree) ≤ Size(tree)
lemma {:induction false} HeightBoundedBySize<T>(tree:BinTree<T>)
  ensures Height(tree) <= Size(tree)
  decreases tree
{
  /*
    Prove this lemma by structural induction on tree.

      Base case, Q(Empty):
        Show that     Height(Empty) ≤ Size(Empty)

      Inductive case, Q(left) ∧ Q(right) ⇒ Q(Node(left, x, right)):

        Assume that   Height(left)  ≤ Size(left)
                      Height(right) ≤ Size(right)
                      
        Prove that    Height(Node(left, x, right))
                      ≤ Size(Node(left, x, right))

    In the inductive case, the induction hypotheses apply to the two
    structurally smaller subtrees, left and right. Use the definition 
    of maximum to bound the maximum of their heights by the sum of 
    their sizes.
    
  */
}