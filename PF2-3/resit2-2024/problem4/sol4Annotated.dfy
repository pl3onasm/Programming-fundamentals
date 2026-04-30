/* file: sol4Annotated.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 4
                with annotations
*/

method problem4(a:nat, b:nat) returns (x:nat)
  requires a > 0 && b > 0
{
  var y:nat;
  x := a;
  y := b;

  /* 
    Idea:
    We start from two positive natural numbers a and b, and
    assign them to x and y.

    The loop repeatedly subtracts the smaller of the two from
    the larger:
      - If x > y, we do x := x - y.
      - Otherwise (x <= y and x != y), we do y := y - x.

    This is the standard subtraction-based Euclidean algorithm:
    it preserves the greatest common divisor of the pair (x, y),
    and gradually reduces both numbers until they become equal.

    To prove correctness, we need to provide:
      (1) a suitable loop invariant
      (2) a suitable variant to show termination

    (1) Loop invariant:  x > 0 && y > 0

      This says that both x and y remain strictly positive
      throughout the loop.

      Initially, we have:
        x = a, y = b, with a > 0 and b > 0 by the precondition,
        so the invariant holds at the start.
      The invariant is also preserved by the loop body, as shown
      below.

    (2) Variant (termination argument): x + y

      This measures the combined size of x and y.
      Since x > 0 and y > 0, we have x + y > 0 at all times.
      And as shown below: in every iteration, the variant  
      strictly decreases, so the loop must terminate.
  */

  while x != y 
    invariant x > 0 && y > 0
    decreases x + y
  {
    if x > y 
    {
      /* Case x > y:
          x' = x - y > 0, y unchanged > 0,
          so the invariant is preserved.
          The new sum is:
            x' + y = (x - y) + y = x < x + y,
          so the variant decreases.
      */
      x := x - y;
    } 
    
    else 
    {
      /* Case x <= y and x != y ⇒ x < y:
          y' = y - x > 0, x unchanged > 0,
          so the invariant is preserved.
          The new sum is:
            x + y' = x + (y - x) = y < x + y,
          so the variant decreases.
      */
      y := y - x;
    }
  }

  /* Loop exit:
      The loop stops when x != y is false, i.e. when x == y.
      Combined with the invariant x > 0 && y > 0, we obtain:
        x == y > 0
      So upon termination the method returns a positive value x
      which equals y and is the greatest common divisor of the
      original inputs a and b.
  */
}