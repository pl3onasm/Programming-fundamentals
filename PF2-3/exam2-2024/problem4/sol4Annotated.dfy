/* file: sol4Annotated.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 4
                with annotations
*/

method problem4(a: nat, b:nat) 
  requires a >= b
{
  var x := a;
  var y := b;

  /* 
    Idea:
    We start from two natural numbers a and b with a >= b,
    which we assign to x and y respectively.
    The loop repeatedly updates x and y until they become equal,
    at which point we assert x == y.

    In each iteration of the loop we do the following:
      - We increase y by 1.
      - Then we replace x by the largest multiple of the new y
        that is less than or equal to the old x, namely:
          x' = x - (x % y).

    To prove correctness, we need to provide:
      (1) a suitable loop invariant
      (2) a suitable variant (decreasing measure) to show termination

    (1) The invariant we use is: x >= y
      
      This captures that x is always at least as large as y.
      Initially, from a >= b and x = a, y = b we have:
        x >= y, so the invariant holds at the start.

      It is preserved by the loop body as follows.
        After increasing y by 1, we have:
          y' = y + 1 <= x,
        so the new y is at most the old x.
        Now we overwrite x using this new y':
          let r = x % y' with 0 <= r < y'.
          Then x' = x - r is a multiple of y', and since x >= y',
          the largest multiple of y' not exceeding x is at least y'.
          Hence x' >= y', so the invariant x >= y holds again.

    (2) As a variant, we choose: x - y, which measures the distance
        between x and y.

      This is always non-negative (because of the invariant and the
      fact that x and y are natural numbers) and decreases by at least 
      one on every iteration of the loop, so the loop must terminate.
  */

  while x != y 
    invariant x >= y 
    decreases x - y
  {
      // First, increase y by 1.
    y := y + 1;

      // Next, replace x by x - x % y (where y is the updated value).
      // This is the largest multiple of y not exceeding the old x.
    x := x - x % y;
  }

  // Loop exit: x != y is false, so x == y.
  // Hence, the assertion holds.
  assert x == y;
}