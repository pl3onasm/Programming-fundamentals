/* file: Math.dfy
   author: David De Potter
   description: reusable mathematical helper functions and arithmetic
   lemmas for Dafny proofs
*/

module MathSupport {

  //========================================================================
  // Returns the smaller of the two integer values x and y.
  function minimum(x:int, y:int): int
  {
    if x <= y then x else y
  }

  //========================================================================
  // Returns the larger of the two integer values x and y.
  function maximum(x:int, y:int): int
  {
    if x >= y then x else y
  }

  //========================================================================
  // Returns the absolute value of x: x itself when x is non-negative,
  // and its additive inverse -x when x is negative.
  function abs(x:int): int
  {
    if x >= 0 then x else -x
  }

  //========================================================================
  // Converts a Boolean value into a natural number. It returns 1 when b
  // is true and 0 when b is false. This is useful for expressing whether
  // a condition contributes one item to a count.
  function ord(b:bool): nat
  {
    if b then 1 else 0
  }

  //========================================================================
  // Composes two total functions:  Compose(f, g)(x) = f(g(x))
  // The result is an anonymous function that first applies g to its input
  // and then applies f to the output of g. The input type A, the
  // intermediate type B, and the output type C can, but need not, be the
  // same. The expression x => f(g(x)) is a lambda expression defining
  // this anonymous function.
  function Compose<A, B, C>(f:B -> C, g:A -> B): A -> C
  {
    x => f(g(x))
  }
  
  //========================================================================
  // Proves that multiplication by the same natural number preserves an
  // inequality: if a <= b, then a*c <= b*c.
  // NOTE: The lemma is proved by induction on c. The recursive call
  // explicitly supplies the induction hypothesis for c-1. Dafny verifies
  // through the decreases clause that the recursive argument becomes
  // strictly smaller.
  lemma MulMonotone(a:nat, b:nat, c:nat)
    requires a <= b
    ensures a*c <= b*c
    decreases c
  {
    if c > 0 
    {
        // Apply the induction hypothesis to multiplication by c-1
      MulMonotone(a,b,c-1);

        // Add a to the left-hand side and b to the right-hand side
      calc 
      {
        a*c;
        == a*(c-1) + a;
        <= b*(c-1) + b;
        == b*c;
      }
    }
  }

  //========================================================================
  // Proves that squaring preserves the order of natural numbers: if
  // a <= b, then a^2 <= b^2.
  lemma SquareMonotone(a:nat, b:nat)
    requires a <= b
    ensures a*a <= b*b
  {
      // First replace the left factor a by b
    MulMonotone(a,b,a);

      // Then replace the right factor a by b
    MulMonotone(a,b,b);

    calc 
    {
      a*a;
      <= b*a;
      == a*b;
      <= b*b;
    }
  }

}
