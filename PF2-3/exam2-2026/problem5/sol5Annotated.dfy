
/* file: sol5Annotated2026.dfy
   author: David De Potter
   description: 2-3rd exam 2026, solution to problem 5
                with annotations
*/

ghost function f(n: nat): int
{
  if n < 2 then n
  else n*f(n-1) + (n+1)*f(n-2)
}

method problem5(n: nat) returns (r: int)
  ensures r == f(n)
{
  /*
    Idea:
    We want to compute f(n) iteratively. Note that the recurrence
    uses two previous results: f(n-1) and f(n-2) for n >= 2.
    Therefore, we keep two consecutive values of f. At the
    start of each iteration, we maintain:

        x == f(k)
        y == f(k+1)

    To advance from k to k+1, we need f(k+2). Applying the
    recurrence with i = k+2 gives:

        f(k+2) = (k+2)*f(k+1) + (k+3)*f(k)
               = (k+2)*y + (k+3)*x

    Thus, we can shift both values forward with the parallel
    assignment:

        x, y := y, (k+2)*y + (k+3)*x

    We initialize k = 0, x = 0 and y = 1, since f(0) = 0 and
    f(1) = 1. This establishes the invariant at the start.

    We also maintain 0 <= k <= n, and use n-k as the variant.
    It is non-negative while the loop runs and decreases by 1
    at each iteration, since k is incremented by 1.
  */

  var k: nat, x: int, y: int := 0, 0, 1;

  while k < n
    invariant 0 <= k <= n
    invariant x == f(k) && y == f(k+1)
    decreases n - k
  {
    x, y := y, (k+2)*y + (k+3)*x;
    k := k + 1;
  }

  /*
    At loop exit:
    k >= n, and the invariant gives k <= n, so k == n.
    The invariant also gives x == f(k) == f(n).

    Hence the active finalization r == x == f(n), yields 
    the postcondition.
  */
  r := x;
}
