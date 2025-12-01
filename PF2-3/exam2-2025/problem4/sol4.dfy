/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 4
*/

method problem4(a: nat, b: nat, c: nat) returns (x: nat, y: nat, z: nat)
  ensures x <= y <= z
  ensures x + y + z == a + b + c
{
  x, y, z := a, b, c;

  /* 
    Idea:
    We start from three natural numbers a, b, c (in arbitrary order)
    and want to end with three numbers x, y, z that satisfy:

        x <= y <= z
        x + y + z = a + b + c

    So we want what we actually want is to sort the triple (a, b, c) 
    into non-decreasing order, while preserving the total sum. 
    This is expressed by the loop condition, which tests whether
    at least one of the inequalities x > y or y > z holds. When that 
    is the case, we perform updates to reduce these drops in order to
    bring the triple closer to non-decreasing order.

    Concretely, in each iteration of the loop we do the following:
      - If x > y, we decrease x by 1 and increase y by 1.
      - If y > z, we decrease y by 1 and increase z by 1.

    In other words, whenever there is a drop (x > y or y > z), we
    shift 1 unit of mass to the right across that drop, thereby
    reducing the drop by 1.

    Both if-statements are independent (no else), so in an iteration
    where x > y and y > z both hold, both updates will execute in
    sequence.

    To prove correctness, we need to provide:
      (1) a suitable loop invariant
      (2) a suitable variant (decreasing measure) to show termination

    (1) We choose the following loop invariant:

        x + y + z == a + b + c

      This expresses that the total sum is preserved: we only move
      units between x, y, z, so the sum remains constant. 
      Initially, we have x = a, y = b, z = c, so the invariant
      holds at the start. It is preserved by the loop body, since
      each update decreases one variable by 1 and increases another
      by 1, leaving the sum unchanged.

    (2) As a variant, we use:

        (a + b + c) - (z - x)

      Here z - x measures the spread between the smallest position (x)
      and the largest position (z); increasing z - x corresponds to
      pushing x down or z up. Since the total sum a + b + c is fixed,
      we can use (a + b + c) - (z - x) as a measure of how far we
      are from having x and z as far apart as possible.

      Initially, we have x = a, y = b, z = c, so the variant is:
        (a + b + c) - (c - a) = a + b + a = 2*a + b >= 0,
      since a, b, c are natural numbers.

      In each iteration of the loop, at least one of the two if-branches
      executes (because of the loop condition). In each branch, we
      increase z - x by 1 (either by decreasing x or increasing z),
      so the variant decreases by 1. Since the variant is always
      non-negative and strictly decreases on each iteration, the loop
      must terminate.
  */

  while x > y || y > z
    invariant x + y + z == a + b + c
    decreases (a + b + c) - (z - x)   
  {
    if x > y {
        // Move 1 unit from x to y when x is too large compared to y.
        // This preserves the sum and increases z - x by 1.
      x := x - 1;
      y := y + 1;
    }
    if y > z {
        // Move 1 unit from y to z when y is too large compared to z.
        // This preserves the sum and increases z - x by 1.
      y := y - 1;
      z := z + 1;
    }
  }

  /* Loop exit:
     The loop terminates when x > y || y > z is false, i.e. when:

        not (x > y || y > z)

     which is equivalent to:

        x <= y  and  y <= z

     Together with the invariant:

        x + y + z == a + b + c

     this gives exactly the two postconditions:

        x <= y <= z
        x + y + z == a + b + c
  */
}
