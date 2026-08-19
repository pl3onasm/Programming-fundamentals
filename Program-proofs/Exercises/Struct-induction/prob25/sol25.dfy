/*  file: sol25.dfy
    author: David De Potter
    description: proof by structural induction that mirroring a binary
      tree reverses its inorder traversal
*/

include "../../Support/Datatypes/BinaryTrees.dfy"
include "../prob05/sol05.dfy"

import opened BinaryTrees

//========================================================================
// Proves by structural induction on tree that its mirrored inorder
// traversal is the reverse of its original inorder traversal:
//   Inorder(Mirror(tree)) = Reverse(Inorder(tree))
lemma {:induction false} InorderMirror(tree:BinTree<int>)
  ensures Inorder(Mirror(tree)) == Reverse(Inorder(tree))
  decreases tree
{
  if tree == Empty
  {
      // Base case: Q(Empty) is true
    assert Inorder(Mirror(tree)) == Reverse(Inorder(tree)) by
    {
      calc
      {
        Inorder(Mirror(tree));
          // Replace tree by Empty
        == Inorder(Mirror<int>(Empty));
          // Unfold Mirror(Empty)
        == Inorder<int>(Empty);
          // Unfold Inorder(Empty)
        == [];
          // Fold Reverse([])
        == Reverse([]);
          // Fold Inorder(Empty)
        == Reverse(Inorder<int>(Empty));
          // Replace Empty by tree
        == Reverse(Inorder(tree));
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
      //   Inorder(Mirror(left))  = Reverse(Inorder(left))
      //   Inorder(Mirror(right)) = Reverse(Inorder(right))
    InorderMirror(left);
    InorderMirror(right);

      // Reversing a concatenation reverses the order of its parts.
      // The first call isolates the right traversal, while the second
      // separates the left traversal from the singleton root sequence.
    ReverseConcat(Inorder(left) + [x], Inorder(right));
    ReverseConcat(Inorder(left), [x]);

      // Inductive case
      // Prove Q(Node(left, x, right)) is true
    calc
    {
      Inorder(Mirror(tree));
        // Replace tree by Node(left, x, right)
      == Inorder(Mirror(Node(left, x, right)));
        // Unfold Mirror
      == Inorder(Node(Mirror(right), x, Mirror(left)));
        // Unfold Inorder
      == Inorder(Mirror(right)) + [x] + Inorder(Mirror(left));
        // Apply both induction hypotheses
      == Reverse(Inorder(right)) + [x] + Reverse(Inorder(left));
        // Replace [x] by Reverse([x])
      == Reverse(Inorder(right)) + Reverse([x]) + Reverse(Inorder(left));
        // Sequence concatenation is associative, so we can regroup 
        // the three parts
      == Reverse(Inorder(right))
           + (Reverse([x]) + Reverse(Inorder(left)));
        // Apply ReverseConcat in reverse
      == Reverse(Inorder(right)) + Reverse(Inorder(left) + [x]);
        // Apply ReverseConcat in reverse again
      == Reverse((Inorder(left) + [x]) + Inorder(right));
        // Fold Inorder(Node(left, x, right))
      == Reverse(Inorder(Node(left, x, right)));
        // Replace Node(left, x, right) by tree
      == Reverse(Inorder(tree));
    }
  }
}
