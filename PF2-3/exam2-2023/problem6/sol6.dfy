/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 6
*/

ghost function f(n: nat): int {
  if n <= 1 then n else 2 * f(n - 1) + 3 * f(n - 2)
}

ghost function fSum(n: nat): int {
  // Returns the sum of the first n values of f:
  //   fSum(n) = Σ_{i=0}^{n-1} f(i)
  if n == 0 then 0 else f(n - 1) + fSum(n - 1)
}

method problem6(n: nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y;

  /*  Idea:
      The function f is defined by a linear recurrence 
      of order 2:
        f(n) = 2*f(n-1) + 3*f(n-2)  for n > 1
        with base cases
          f(0) = 0, f(1) = 1

      We want to compute the sum of the first n values
      of f in an efficient, iterative way. That is, we 
      want to compute: fSum(n) = Σ_{i=0}^{n-1} f(i)

      For this, we iterate with a counter k, maintaining
      at the **start of each loop iteration**:
          • k = how many terms have already been
                added into a
          • a = sum of f(0), ..., f(k-1),
                i.e. a == fSum(k)
          • x = f(k), y = f(k+1)

      In other words, at loop entry we have:
          (a, x, y, k) = (fSum(k), f(k), f(k+1), k)

      Inside the loop body, we perform these steps:
          (1) increment k
          (2) add the value x, which still holds f(k-1)
              with respect to the new k, so afterwards:
                a = fSum(k-1) + f(k-1) = fSum(k)
          (3) shift (x, y) forward by 1 using 
              the recurrence for f, so that at the
              end of the iteration we restore:
                x = f(k), y = f(k+1)

      Thus, by the time we reach the next loop entry,
      the invariant holds again in its original form.

      When k reaches n, a will equal fSum(n).

      We initialise as follows:
          k = 0
          x = f(0) = 0
          y = f(1) = 1
          a = fSum(0) = 0

      So that the invariant holds at the start.
  */

  a, k, x, y := 0, 0, 0, 1;
  
  while k < n
    invariant 0 <= k <= n && x == f(k) 
              && y == f(k + 1) && a == fSum(k)
  {   
      // Step (1): increment k
    k := k + 1;

      // Step (2): add the value f(k-1), which is x
      //   so that afterwards a = fSum(k)
    a := a + x;

      // Step (3) : shift (x,y) forward by 1 
      //   Currently (wrt the updated k), we have:
      //     (x, y) = (f(k-1), f(k))
      //   We need to update (x,y) to:
      //     (x, y) = (f(k), f(k+1))
      //   using f's recurrence, in order to restore
      //   the invariant at the next loop entry.
      //   Here we perform these updates sequentially
    y := 2 * y + 3 * x;
    x := (y - 3 * x) / 2;
  }

  /* Loop exit: k >= n and 0 <= k <= n ⇒ k == n
    
     Invariant gives:
       a == fSum(k) == fSum(n)
    
     Hence, a is the sum of the first n values of f,
     as intended.
  */
}

/* Alternatively, the following loop body can be used:
  
  k := k + 1;
  a := a + x;
  y, x := 2 * y + 3 * x, y; 

  It is equivalent to the loop body above, 
  but more concise. Here the double assignment
  expresses the intended parallel update directly:
    (x,y) := (f(k), f(k+1))
*/