/*  file: sol25.dfy
    author: David De Potter
    description: proofs by finite-set induction of cardinality properties
      of the image of a set
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Defines the image of a finite set s under a function f:
//   Image(f, S) = {f(x) | x ∈ S}
// Different elements of S may have the same image under f, but sets do
// not retain duplicate values. Therefore, the image of a finite set  
// may have fewer elements than the original set.
ghost function Image<A, B>(f:A -> B, S:set<A>): set<B>
{
  set x | x in S :: f(x)
}

//========================================================================
// Proves by induction on S that taking its image cannot increase its
// cardinality:  |Image(f, S)| ≤ |S|
lemma {:induction false} ImageCardinalityBound<A, B>(f:A -> B, S:set<A>)
  ensures   |Image(f, S)| <= |S|
  decreases |S|
{
  if S == {}
  {
      // Base case: Q({}) is true
    assert |Image(f, S)| <= |S| by
    {
      calc
      {
        |Image(f, S)|;
          // Rewrite S as the empty set
        == |Image(f, {})|;
          // The image of the empty set is empty, and
          // the cardinality of the empty set is 0
        == 0;
          // The set S is empty, so its cardinality is 0
        == |S|;
          // Arithmetic
        <= |S|;
      }
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set S. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:A :| x in S;
    var R := S - {x};

      // The image of S consists of the image of R 
      // together with the possibly new value f(x)
    SetEquality(Image(f, S), Image(f, R) + {f(x)});

      // Induction hypothesis
      // Assume Q(R) is true:  |Image(f, R)| ≤ |R|
    ImageCardinalityBound(f, R);

    if f(x) in Image(f, R)
    {
        // If f(x) is already present, inserting x 
        // does not enlarge the image at all.
      assert Image(f, R) + {f(x)} == Image(f, R);

      calc
      {
        |Image(f, S)|;
          // Rewrite the image of S
        == |Image(f, R) + {f(x)}|;
          // f(x) is already present, so 
          // inserting it does not enlarge the image
        == |Image(f, R)|;
          // Apply the induction hypothesis
        <= |R|;
          // Inserting x enlarges R by one
        <= |R| + 1;
          // The reconstructed set is S
        == |S|;
      }
    }

    else
    {
        // If f(x) is new, it enlarges the 
        // image by exactly one.
      InsertCardinality(Image(f, R), f(x));

      calc
      {
        |Image(f, S)|;
          // Rewrite the image of S
        == |Image(f, R) + {f(x)}|;
          // f(x) is new, so inserting it 
          // enlarges the image by one
        == |Image(f, R)| + 1;
          // Apply the induction hypothesis
        <= |R| + 1;
          // Since R = S - {x} and x ∈ S, we have |R| + 1 = |S|
        == |S|;
      }
    }
  }
}

//========================================================================
// Proves that the image of a finite set has the same cardinality as the
// original set when f is injective on S, i.e. when different elements
// of S have different images under f. The precondition expresses this
// using the equivalent contrapositive formulation: if two elements of S
// have the same image, then they must be equal. This formulation is more
// convenient for the finite-set induction proof.
lemma {:induction false} InjectImageCardinality<A, B>(f:A -> B, S:set<A>)
  requires forall x, y :: x in S && y in S && f(x) == f(y) ==> x == y
  ensures   |Image(f, S)| == |S|
  decreases |S|
{
  if S == {}
  {
      // Base case: Q({}) is true
    assert |Image(f, S)| == |S| by
    {
      calc
      {
        |Image(f, S)|;
          // Rewrite S as the empty set
        == |Image(f, {})|;
          // The image of the empty set is empty, and
          // the cardinality of the empty set is 0
        == 0;
          // The set S is empty, so its cardinality is 0
        == |S|;
      }
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set S. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:A :| x in S;
    var R := S - {x};

      // Induction hypothesis
      // Assume Q(R) is true:  |Image(f, R)| = |R|
    InjectImageCardinality(f, R);

      // Injectivity ensures that f(x) cannot already occur in the image
      // of R. Otherwise some y ∈ R would satisfy f(y) = f(x),
      // forcing y = x even though x ∉ R.
    assert f(x) !in Image(f, R) by
    {
      if f(x) in Image(f, R)
      {
        var y:A :| y in R && f(y) == f(x);
        assert y == x;
        assert false;
      }
    }

      // Inserting x adds the genuinely new value f(x) to the image.
    SetEquality(Image(f, S), Image(f, R) + {f(x)});
    InsertCardinality(Image(f, R), f(x));

    calc
    {
      |Image(f, S)|;
        // Rewrite the image of S
      == |Image(f, R) + {f(x)}|;
        // f(x) is new, so inserting it 
        // enlarges the image by one
      == |Image(f, R)| + 1;
        // Apply the induction hypothesis
      == |R| + 1;
        // The reconstructed set is S
      == |S|;
    }
  }
}
