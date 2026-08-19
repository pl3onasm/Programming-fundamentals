/*  file: sol22.dfy
    author: David De Potter
    description: Proof by structural induction that the height of a
      binary tree is bounded by its size.
      In fact, equality holds for a degenerate tree in which every node 
      has at most one nonempty subtree.
*/

include "../../Support/Datatypes/BinaryTrees.dfy"
include "../../Support/Math.dfy"

import opened BinaryTrees
import opened MathSupport

//========================================================================
// Proves by structural induction on tree that its height is at most its
// number of nodes:  Height(tree) ≤ Size(tree)
lemma {:induction false} HeightBoundedBySize<T>(tree:BinTree<T>)
  ensures Height(tree) <= Size(tree)
  decreases tree
{
  if tree == Empty
  {
      // Base case: Q(Empty) is true
    assert Height(tree) <= Size(tree) by
    {
      calc
      {
        Height(tree);
          // Replace tree by Empty
        == Height<T>(Empty);
          // Unfold Height(Empty)
        == 0;
          // Arithmetic
        <= 0;
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
      //   Height(left)  ≤ Size(left)
      //   Height(right) ≤ Size(right)
    HeightBoundedBySize(left);
    HeightBoundedBySize(right);

      // The maximum of the two subtree heights is bounded 
      // by the sum of the sizes of both subtrees.
    if Height(left) >= Height(right)
    {
      calc
      {
        maximum(Height(left), Height(right));
          // Unfold maximum using Height(left) ≥ Height(right)
        == Height(left);
          // Apply the induction hypothesis for left
        <= Size(left);
          // Add the size of the right subtree
        <= Size(left) + Size(right);
      }
    }
    else
    {
      calc
      {
        maximum(Height(left), Height(right));
          // Unfold maximum using Height(left) < Height(right)
        == Height(right);
          // Apply the induction hypothesis for right
        <= Size(right);
          // Add the size of the left subtree
        <= Size(left) + Size(right);
      }
    }

      // Inductive case
      // Prove Q(Node(left, x, right)) is true
    calc
    {
      Height(tree);
        // Replace tree by Node(left, x, right)
      == Height(Node(left, x, right));
        // Unfold Height
      == 1 + maximum(Height(left), Height(right));
        // Apply the bound established above
      <= 1 + Size(left) + Size(right);
        // Fold Size
      == Size(Node(left, x, right));
        // Replace Node(left, x, right) by tree
      == Size(tree);
    }
  }
}
