/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 6
*/

ghost function f(n: nat): int {
  if n <= 2 then 2*n else f(n-1) + 2*f(n-2) + 3*f(n-3)
}

ghost function fSum(n: nat): int {
  // Returns the sum of the first n values of f:
  //   fSum(n) = Σ_{i=0}^{n-1} f(i)
  if n == 0 then 0 else f(n - 1) + fSum(n-1)
}

method problem6(n:nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y, z;

  /*  
    Idea:
    The function f is defined by a linear recurrence 
    of order 3:
      f(n) = f(n-1) + 2*f(n-2) + 3*f(n-3)  for n > 2
      with base cases
        f(0) = 0, f(1) = 2, f(2) = 4

    We want to compute the sum of the first n values
    of f in an efficient, non-recursive way. That is, 
    we want to compute: fSum(n) = Σ_{i=0}^{n-1} f(i)

    For this, we iterate with a counter k, maintaining
    at the **start of each loop iteration**:
        • k = how many terms have already been
              added into a
        • a = sum of f(0), ..., f(k-1),
              that is a == fSum(k)
        • x = f(k), y = f(k+1), z = f(k+2)

    In other words, at loop entry we have:
        (a, x, y, z, k) = (fSum(k), f(k), f(k+1), f(k+2), k)

  Inside the loop body, we perform these steps:
        (1) increment k
        (2) add the value x, which still holds f(k-1)
            with respect to the new k, so afterwards:
              a = fSum(k-1) + f(k-1) = fSum(k)
        (3) shift (x, y, z) forward by 1 using 
            the recurrence for f, so that at the
            end of the iteration we restore:
              x = f(k), y = f(k+1), z = f(k+2)

    Thus, by the time we reach the next loop entry,
    the invariant holds again in its original form.

    When k reaches n, a will equal fSum(n).

    We initialise as follows:
        k = 0
        x = f(0) = 0
        y = f(1) = 2
        z = f(2) = 4
        a = fSum(0) = 0

    So that the invariant holds at the start.
  */

  a, k, x, y, z := 0, 0, 0, 2, 4; 

  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k+1) 
              && z == f(k+2) && a == fSum(k)
  {
      // Step (1) : increment k
    k := k + 1;

      // Step (2) : add the value f(k-1), which is x
      //   so that afterwards a = fSum(k)
    a := a + x;

      // Step (3) : shift (x,y,z) forward by 1 
      //   Currently (wrt the updated k), we have:
      //     (x, y, z) = (f(k-1), f(k), f(k+1))
      //   We need to update (x,y,z) to:
      //     (x, y, z) = (f(k), f(k+1), f(k+2))
      //   using f's recurrence, in order to restore
      //   the invariant at the next loop entry.
      //   Here we perform these updates sequentially
    z := z + 2*y + 3*x;
    y := z - 2*y - 3*x;
    x := (z - y - 3*x) / 2;
  }

  /* Loop exit: k >= n and 0 <= k <= n ⇒ k == n
    
     Invariant gives:
       a == fSum(k) == fSum(n)
    
     Hence, a is the sum of the first n values of f,s
     as intended.
  */
}


/* Alternatively, the following loop body can be used:
  
  k := k + 1;
  a := a + x;
  z, y, x := z + 2*y + 3*x, z, y;

  It is equivalent to the loop body above, 
  but more concise. Here the triple assignment
  expresses the intended parallel update directly:
    (x,y,z) := (f(k), f(k+1), f(k+2))
*/