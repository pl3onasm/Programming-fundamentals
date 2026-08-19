/*  file: sol24.dfy
    author: David De Potter
    description: proof by structural induction that mapping composed
      functions over a binary tree is equivalent to successive mappings
*/

include "../../Support/Datatypes/BinaryTrees.dfy"
include "../../Support/Math.dfy"

import opened BinaryTrees
import opened MathSupport

//========================================================================
// Proves by structural induction on tree that mapping g and then f is
// equivalent to mapping their composition once:
//   MapTree(f, MapTree(g, tree)) = MapTree(Compose(f, g), tree)
lemma {:induction false} 
MapTreeComposition<A, B, C>(f:B -> C, g:A -> B, tree:BinTree<A>)
  ensures MapTree(f, MapTree(g, tree)) == MapTree(Compose(f, g), tree)
  decreases tree
{
  if tree == Empty
  {
      // Base case: Q(Empty) is true
    assert MapTree(f, MapTree(g, tree)) == MapTree(Compose(f, g), tree) by
    {
      calc
      {
        MapTree(f, MapTree(g, tree));
          // Replace tree by Empty
        == MapTree(f, MapTree(g, Empty));
          // Unfold the inner application of MapTree
        == MapTree(f, Empty);
          // Unfold the outer application of MapTree
        == Empty;
          // Fold MapTree(Compose(f, g), Empty)
        == MapTree(Compose(f, g), Empty);
          // Replace Empty by tree
        == MapTree(Compose(f, g), tree);
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
      //   MapTree(f, MapTree(g, left))  = MapTree(Compose(f, g), left)
      //   MapTree(f, MapTree(g, right)) = MapTree(Compose(f, g), right)
    MapTreeComposition(f, g, left);
    MapTreeComposition(f, g, right);

      // Inductive case
      // Prove Q(Node(left, x, right)) is true
    calc
    {
      MapTree(f, MapTree(g, tree));
        // Replace tree by Node(left, x, right)
      == MapTree(f, MapTree(g, Node(left, x, right)));
        // Unfold the inner application of MapTree
      == MapTree(f, Node(MapTree(g, left), g(x), MapTree(g, right)));
        // Unfold the outer application of MapTree
      == Node(MapTree(f, MapTree(g, left)),
              f(g(x)), MapTree(f, MapTree(g, right)));
        // Apply both induction hypotheses and the definition of Compose
      == Node(MapTree(Compose(f, g), left),
              Compose(f, g)(x), MapTree(Compose(f, g), right));
        // Fold MapTree(Compose(f, g), Node(left, x, right))
      == MapTree(Compose(f, g), Node(left, x, right));
        // Replace Node(left, x, right) by tree
      == MapTree(Compose(f, g), tree);
    }
  }
}