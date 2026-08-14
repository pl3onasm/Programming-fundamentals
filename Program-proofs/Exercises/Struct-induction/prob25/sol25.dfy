/*  file: sol25.dfy
    author: David De Potter
    description: proofs by finite-set induction of cardinality properties
      of the image of a set
*/

include "../../Support/Sets.dfy"
import opened SetSupport

//========================================================================
// Defines the image of a finite set s under a function f:
//   Image(f, s) = {f(x) | x ∈ s}
// Different elements of s may have the same image under f, but sets do
// not retain duplicate values. Therefore, the image of a finite set  
// may have fewer elements than the original set.
ghost function Image<A, B>(f:A -> B, s:set<A>): set<B>
{
  set x | x in s :: f(x)
}

//========================================================================
// Proves by induction on s that taking its image cannot increase its
// cardinality:  |Image(f, s)| ≤ |s|
lemma {:induction false} ImageCardinalityBound<A, B>(f:A -> B, s:set<A>)
  ensures   |Image(f, s)| <= |s|
  decreases |s|
{
  if s == {}
  {
      // Base case: Q({}) is true
    assert |Image(f, s)| <= |s| by
    {
      calc
      {
        |Image(f, s)|;
          // Rewrite s as the empty set
        == |Image(f, {})|;
          // The image of the empty set is empty, and
          // the cardinality of the empty set is 0
        == 0;
          // The set s is empty, so its cardinality is 0
        == |s|;
          // Arithmetic
        <= |s|;
      }
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set s. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:A :| x in s;
    var R := s - {x};

      // The image of s consists of the image of R 
      // together with the possibly new value f(x)
    SetEquality(Image(f, s), Image(f, R) + {f(x)});

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
        |Image(f, s)|;
          // Rewrite the image of s
        == |Image(f, R) + {f(x)}|;
          // f(x) is already present, so 
          // inserting it does not enlarge the image
        == |Image(f, R)|;
          // Apply the induction hypothesis
        <= |R|;
          // Inserting x enlarges R by one
        <= |R| + 1;
          // The reconstructed set is s
        == |s|;
      }
    }

    else
    {
        // If f(x) is new, it enlarges the 
        // image by exactly one.
      InsertCardinality(Image(f, R), f(x));

      calc
      {
        |Image(f, s)|;
          // Rewrite the image of s
        == |Image(f, R) + {f(x)}|;
          // f(x) is new, so inserting it 
          // enlarges the image by one
        == |Image(f, R)| + 1;
          // Apply the induction hypothesis
        <= |R| + 1;
          // The reconstructed set is s
        == |s|;
      }
    }
  }
}

//========================================================================
// Proves that the image of a finite set has the same cardinality as the
// original set when f is injective on s, i.e. when different elements
// of s have different images under f. The precondition expresses this
// using the equivalent contrapositive formulation: if two elements of s
// have the same image, then they must be equal. This formulation is more
// convenient for the finite-set induction proof.
lemma {:induction false} InjectImageCardinality<A, B>(f:A -> B, s:set<A>)
  requires forall x, y :: x in s && y in s && f(x) == f(y) ==> x == y
  ensures   |Image(f, s)| == |s|
  decreases |s|
{
  if s == {}
  {
      // Base case: Q({}) is true
    assert |Image(f, s)| == |s| by
    {
      calc
      {
        |Image(f, s)|;
          // Rewrite s as the empty set
        == |Image(f, {})|;
          // The image of the empty set is empty, and
          // the cardinality of the empty set is 0
        == 0;
          // The set s is empty, so its cardinality is 0
        == |s|;
      }
    }
  }

  else
  {
      // Choose an arbitrary element x of the nonempty set s. Removing x
      // gives the strictly smaller set R used for the induction step.
    var x:A :| x in s;
    var R := s - {x};

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
    SetEquality(Image(f, s), Image(f, R) + {f(x)});
    InsertCardinality(Image(f, R), f(x));

    calc
    {
      |Image(f, s)|;
        // Rewrite the image of s
      == |Image(f, R) + {f(x)}|;
        // f(x) is new, so inserting it 
        // enlarges the image by one
      == |Image(f, R)| + 1;
        // Apply the induction hypothesis
      == |R| + 1;
        // The reconstructed set is s
      == |s|;
    }
  }
}
