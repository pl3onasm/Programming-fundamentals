/*  file: sol23.dfy
    author: David De Potter
    description: proof by structural induction that mirroring a binary
      tree twice returns the original tree
*/

include "../../Support/Datatypes/Finite/BinaryTrees.dfy"
import opened BinaryTrees

//========================================================================
// Proves by structural induction on tree that mirroring it twice returns
// the original tree:  Mirror(Mirror(tree)) = tree
lemma {:induction false} MirrorTwice<T>(tree:BinTree<T>)
  ensures Mirror(Mirror(tree)) == tree
  decreases tree
{
  if tree == Empty
  {
      // Base case: Q(Empty) is true
    assert Mirror(Mirror(tree)) == tree by
    {
      calc
      {
        Mirror(Mirror(tree));
          // Replace tree by Empty
        == Mirror(Mirror<T>(Empty));
          // Unfold the inner application of Mirror
        == Mirror<T>(Empty);
          // Unfold the outer application of Mirror
        == Empty;
          // Replace Empty by tree
        == tree;
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
      //   Mirror(Mirror(left))  = left
      //   Mirror(Mirror(right)) = right
    MirrorTwice(left);
    MirrorTwice(right);

      // Inductive case
      // Prove Q(Node(left, x, right)) is true
    calc
    {
      Mirror(Mirror(tree));
        // Replace tree by Node(left, x, right)
      == Mirror(Mirror(Node(left, x, right)));
        // Unfold the inner application of Mirror
      == Mirror(Node(Mirror(right), x, Mirror(left)));
        // Unfold the outer application of Mirror
      == Node(Mirror(Mirror(left)), x, Mirror(Mirror(right)));
        // Apply both induction hypotheses
      == Node(left, x, right);
        // Replace Node(left, x, right) by tree
      == tree;
    }
  }
}