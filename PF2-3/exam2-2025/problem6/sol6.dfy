/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 6
*/

ghost function f(n: nat): int {
  if n <= 1 
  then n
  else if n % 2 == 0
       then 1 + f(n - 2)
       else f(n - 1) + f(n - 3)
}

ghost function fSum(n: nat): int {
  // Returns the sum of the first n values of f:
  //   fSum(n) = Σ_{i=0}^{n-1} f(i)
  if n == 0 then 0 else f(n - 1) + fSum(n - 1)
}

method problem6(n:nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y, z;

  /*  Idea:
      The function f is defined by a recurrence that depends
      on the parity of n:
        f(n) = 0                     if n == 0
               1                     if n == 1
               1 + f(n-2)            if n > 1 and n even
               f(n-1) + f(n-3)       if n > 1 and n odd

      We want to compute the sum of the first n values
      of this function f in an efficient, non-recursive way.
      That is, we want to compute: fSum(n) = Σ_{i=0}^{n-1} f(i)

      For this, we iterate with a counter k, maintaining
      at the **start of each loop iteration**:
          • k = how many terms have already been
                added into a
          • a = sum of f(0), ..., f(k-1),
                i.e. a == fSum(k)
          • x = f(k), y = f(k+1), z = f(k+2)

      In other words, at loop entry we have:
          (a, x, y, z, k) = (fSum(k), f(k), f(k+1), f(k+2), k)

      Inside the loop body, we perform these steps:
          (1) increment k
          (2) add the value x, which still holds f(k-1)
              with respect to the new k, so afterwards:
                a = fSum(k-1) + f(k-1) = fSum(k)
          (3) update (x, y, z) using the parity of k and
              the recurrence for f, so that at the end
              of the iteration we restore:
                x = f(k), y = f(k+1), z = f(k+2)

      Concretely, after step (1) we know:
          x = f(k-1), y = f(k), z = f(k+1)
      and then we distinguish on the parity of this k:
        - if k is even:
            we use      f(k+2) = 1 + f(k)
        - if k is odd:
            we use      f(k+2) = f(k+1) + f(k-1)
        to compute the new z, while x and y are shifted forward.

      Thus, by the time we reach the next loop entry,
      the invariant holds again in its original form.

      When k reaches n, a will equal fSum(n).

      We initialise as follows:
          k = 0
          x = f(0) = 0
          y = f(1) = 1
          z = f(2) = 1      (since f(2) = 1 + f(0) = 1)
          a = fSum(0) = 0

      So that the invariant holds at the start.
  */

  a, k, x, y, z := 0, 0, 0, 1, 1;

  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k + 1) 
              && z == f(k + 2) && a == fSum(k)
  {
      // Step (1) : increment k
    k := k + 1;

      // Step (2) : add the value f(k-1), which is x
      //   to the running sum a 
    a := a + x;         
      
      // Step (3) : update (x,y,z) 
      //   Currently (wrt the updated k), we have:
      //     (x, y, z) = (f(k-1), f(k), f(k+1))
      //   We need to update (x,y,z) to:
      //     (x, y, z) = (f(k), f(k+1), f(k+2))
      //   using the parity of k and f's recurrence.
      //   Here we perform the updates sequentially
    if k % 2 == 0 {     
      x := y;           // x = f(k)
      y := z;           // y = f(k+1)
      z := 1 + x;       // z = f(k+2) = 1 + f(k)

    } else {            
      var oldX := x;    // oldX = f(k-1)
      x := y;           // x = f(k)
      y := z;           // y = f(k+1)
      z := z + oldX;    // z = f(k+2) = f(k+1) + f(k-1)
    }
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
  if k % 2 == 0 {
    x, y, z := y, z, 1 + y;
  } else {
    x, y, z := y, z, z + x;
  }

  It is equivalent to the loop body above, 
  but more concise. Here the triple assignment
  expresses the intended parallel update directly:
    (x,y,z) := (f(k), f(k+1), f(k+2))
*/