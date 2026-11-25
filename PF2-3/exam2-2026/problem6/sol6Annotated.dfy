
/* file: sol6Annotated2026.dfy
   author: David De Potter
   description: 2-3rd exam 2026, solution to problem 6
                with annotations
*/

ghost function f(n: int): int
{
  if n < 2 then n
  else if n % 2 == 0
       then 2*f(n/2) + n
       else 3*f((n+1)/2) + n
}

method problem6(n: int) returns (r: int)
  requires n > 0
  ensures r == f(n)
{
  /*
    Idea:
    We want to evaluate f(n) iteratively. The recursive argument 
    becomes approximately half as large in each step. We 
    therefore start at k = n and repeatedly halve k until we 
    reach the base case k = 1.

    The supplied loop invariant is:

        1 <= k <= n  &&  f(n) == x*f(k) + y*f(k+1) + z

    Intuitively:
      - x and y are scaling factors for the remaining 
        calls f(k) and f(k+1)
      - z accumulates all the terms added by the recurrence

    Initially, k = n and (x,y,z) = (1,0,0), so the invariant
    holds at the start:

        f(n) = 1*f(n) + 0*f(n+1) + 0

    To preserve the invariant when we replace k by k/2, we 
    need to update the coefficients x, y and z accordingly.
    For this, we distinguish between even and odd k. In the 
    calculations we set m = k/2, using integer division.

    EVEN CASE k = 2m:
      f(k)   = 2*f(m)   + k
      f(k+1) = 3*f(m+1) + (k+1)

      Hence:
      x*f(k) + y*f(k+1) + z
        = x*(2*f(m) + k) + y*(3*f(m+1) + (k+1)) + z
        = (2*x)*f(m) + (3*y)*f(m+1) + (z + k*x + (k+1)*y)

      So the new coefficients become:
      x' = 2*x,  y' = 3*y,  z' = z + k*x + (k+1)*y

    ODD CASE k = 2m+1:
      f(k)   = 3*f(m+1) + k
      f(k+1) = 2*f(m+1) + (k+1)

      Hence:
      x*f(k) + y*f(k+1) + z
        = x*(3*f(m+1) + k) + y*(2*f(m+1) + (k+1)) + z
        = (3*x + 2*y)*f(m+1) + (z + k*x + (k+1)*y)
        = 0*f(m) + (3*x+2*y)*f(m+1) + (z + k*x + (k+1)*y)

      So the new coefficients become:
      x' = 0,  y' = 3*x+2*y,  z' = z + k*x + (k+1)*y

    Termination:
      The variant is k. The invariant gives k >= 1; whenever
      the guard k > 1 holds, integer division by 2 strictly
      decreases k but keeps it at least 1.

  */

  var k := n;
  var x, y, z := 1, 0, 0;

  while k > 1
    invariant 1 <= k <= n && f(n) == x*f(k) + y*f(k+1) + z
    decreases k
  {
    if k % 2 == 0
    {
      x, y, z := 2*x, 3*y, z + k*x + (k+1)*y;
    }

    else
    {
      x, y, z := 0, 3*x + 2*y, z + k*x + (k+1)*y;
    }

    k := k/2;
  }

  /*
    At loop exit, we have k <= 1 and invariant k >= 1 give k = 1.
    Substituting f(1) = 1 and f(2) = 4 into the invariant 
    at k = 1 yields:

      f(n) == x*1 + y*4 + z

    Thus, by using active finalization we obtain the 
    required postcondition.
  */

  r := x + 4*y + z;
}
