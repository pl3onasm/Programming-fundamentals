
/* file: sol4Annotated2026.dfy
   author: David De Potter
   description: 2-3rd exam 2026, solution to problem 4
                with annotations
*/

method problem4(a: int, b: int, c: int) returns (x: int, y: int, z: int)
  requires 2 <= a <= b
  ensures 0 <= x < 2 && 0 <= y < 3 && x + 2*y + 5*z == a + 2*b + 5*c
{
  x, y, z := a, b, c;

  /*
    Idea:
    We start from three integers a, b, c, with 2 <= a <= b,
    and want to end with three numbers x, y, z that satisfy:

        0 <= x < 2
        0 <= y < 3
        x + 2*y + 5*z = a + 2*b + 5*c

    Thus, we want to reduce x and y to the indicated ranges,
    while preserving the weighted sum x + 2*y + 5*z. The loop
    continues as long as x >= 2 or y >= 3.

    In each iteration of the loop we do the following:
      - If x >= 2, decrease x by 2 and increase y by 1.
      - If y >= 3, decrease y by 3, increase z by 1, and
        increase x by 1.

    These updates preserve the weighted sum:
      - First branch:  -2 + 2*(+1) = 0.
      - Second branch: (+1) + 2*(-3) + 5*(+1) = 0.

    The two if-statements are independent (no else). The first
    update can make y >= 3, in which case the second update will
    also execute during the same iteration.

    To prove correctness, we need to provide:
      (1) a suitable loop invariant
      (2) a suitable variant (decreasing measure) 

    (1) We choose the following loop invariant:

        0 <= x && 0 <= y &&
        x + 2*y + 5*z == a + 2*b + 5*c

      The first two conjuncts express that x and y remain
      non-negative. Initially, x = a and y = b, so this follows
      from the precondition 2 <= a <= b. Both branches preserve
      non-negativity: we subtract from x only when x >= 2,
      and from y only when y >= 3.

      The third conjunct expresses that the weighted sum is
      preserved. It holds initially because x = a, y = b,
      and z = c. As shown above, neither branch changes it.

    (2) As a variant function, we use: x + y
      Because the invariant guarantees x >= 0 and y >= 0,
      the variant is always non-negative.

      Every loop iteration executes at least one branch:
      - First branch:  x + y changes by -2 + 1 = -1.
      - Second branch: x + y changes by +1 - 3 = -2.

      Therefore x + y strictly decreases on every iteration.
      Since it is an integer bounded below by 0, the loop
      must terminate. 
  */

  while x >= 2 || y >= 3
    invariant 0 <= x && 0 <= y &&
              x + 2*y + 5*z == a + 2*b + 5*c
    decreases x + y
  {
    if x >= 2 {
        // Convert 2 units of x into 1 unit of y.
        // x + y decreases by 1.
      x := x - 2;
      y := y + 1;
    }

    if y >= 3 {
        // Convert 3 units of y into 1 unit of z and 1 of x.
        // x + y decreases by 2.
      y := y - 3;
      z := z + 1;
      x := x + 1;
    }
  }

  /* At loop exit:
     The loop guard x >= 2 || y >= 3 is false, so:

        x < 2  and  y < 3

     Together with the first part of the invariant, 
     0 <= x  and  0 <= y, this gives the required bounds:

        0 <= x < 2  and  0 <= y < 3

     The weighted-sum part of the invariant also still holds:

        x + 2*y + 5*z == a + 2*b + 5*c

     Thus, all parts of the postcondition are satisfied.
  */
}
