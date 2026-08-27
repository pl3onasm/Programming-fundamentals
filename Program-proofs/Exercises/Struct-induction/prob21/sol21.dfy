/*  file: sol21.dfy
    author: David De Potter
    description: proof by structural induction that the length of an
      inorder traversal equals the size of the tree
*/

include "../../Support/Datatypes/Finite/BinaryTrees.dfy"
import opened BinaryTrees

//========================================================================
// Proves by structural induction on tree that the length of its inorder
// traversal equals its number of nodes:  |Inorder(tree)| = Size(tree)
lemma {:induction false} InorderLength<T>(tree:BinTree<T>)
  ensures |Inorder(tree)| == Size(tree)
  decreases tree
{
  if tree == Empty
  {
      // Base case: Q(Empty) is true
    assert |Inorder(tree)| == Size(tree) by
    {
      calc
      {
        |Inorder(tree)|;
          // Replace tree by Empty
        == |Inorder<T>(Empty)|;
          // Unfold Inorder(Empty); the length
          // of the empty sequence is 0
        == 0;
          // Fold Size(Empty)
        == Size<T>(Empty);
          // Replace Empty by tree
        == Size(tree);
      }
    }
  }

  else
  {
      // Since tree ≠ Empty, it has the form 
      // Node(tree.left, tree.value, tree.right)
      // Let left and right denote its two structurally smaller 
      // subtrees, and let x denote its root value.
    var left  := tree.left;
    var x     := tree.value;
    var right := tree.right;

      // Induction hypotheses
      // Assume Q(left) and Q(right) are true:
      //   |Inorder(left) | = Size(left)
      //   |Inorder(right)| = Size(right)
    InorderLength(left);
    InorderLength(right);

      // Inductive case
      // Prove Q(Node(left, x, right)) is true
    calc
    {
      |Inorder(tree)|;
        // Replace tree by Node(left, x, right)
      == |Inorder(Node(left, x, right))|;
        // Unfold Inorder
      == |Inorder(left) + [x] + Inorder(right)|;
        // The length of a concatenation is the sum of its lengths
      == |Inorder(left)| + 1 + |Inorder(right)|;
        // Apply both induction hypotheses
      == Size(left) + 1 + Size(right);
        // Addition is commutative
      == 1 + Size(left) + Size(right);
        // Fold Size
      == Size(Node(left, x, right));
        // Replace Node(left, x, right) by tree
      == Size(tree);
    }
  }
}
