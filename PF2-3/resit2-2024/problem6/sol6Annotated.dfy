/* file: sol6Annotated.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 6
                with annotations
*/

ghost function f(n: int) : int 
{
    // Returns the n-th term of the sequence f
  if n <= 2 
  then n + 1
  else 2*f(n - 1) + 3*f(n - 2) - f(n - 3)
}

ghost function fProduct(n: nat): int 
{
    // Returns the product of the first n values of f:
    //   fProduct(n) = Π_{i=0}^{n-1} f(i)
  if n == 0 then 1 else f(n - 1) * fProduct(n - 1)
}

method problem6(n: nat) returns (a: int)
requires n >= 0
{
  var x,y,z: int;
  var k : nat;

  /*  Idea:
      The function f is defined by a linear recurrence 
      of order 3:
        f(n) = 2*f(n-1) + 3*f(n-2) - f(n-3)  for n > 2
        with base cases
          f(0) = 1, f(1) = 2, f(2) = 3

      We want to compute the product of the first n values
      of f in an efficient, non-recursive way. That is, 
      we want to compute: fProduct(n) = Π_{i=0}^{n-1} f(i)

      For this, we iterate with a counter k, maintaining
      at the **start of each loop iteration**:
          • k = how many terms have already been
                multiplied into a
          • a = product of f(0), ..., f(k-1),
                i.e. a == fProduct(k)
          • x = f(k), y = f(k+1), z = f(k+2)

      In other words, at loop entry we have:
          (a, x, y, z, k) = (fProduct(k), f(k), f(k+1), f(k+2), k)

      Inside the loop body, we will perform these steps:
          (1) increment k
          (2) multiply a by the value x, which still holds
              f(k-1) with respect to the new k, so afterwards:
                a = fProduct(k-1) * f(k-1) = fProduct(k)
          (3) shift (x, y, z) forward by 1 using 
              the recurrence for f, so that at the
              end of the iteration we restore:
                x = f(k), y = f(k+1), z = f(k+2)

      Thus, by the time we reach the next loop entry,
      the invariant holds again in its original form.

      When k reaches n, a will equal fProduct(n).

      We initialise as follows:
          k = 0
          x = f(0) = 1
          y = f(1) = 2
          z = f(2) = 3
          a = fProduct(0) = 1

      So that the invariant holds at the start.
  */

  a, k, x, y, z := 1, 0, 1, 2, 3;
  
  while k < n
  invariant 0 <= k <= n &&  x == f(k) && y == f(k + 1) 
            && z == f(k + 2) && a == fProduct(k)
  decreases n - k
  {
      // Step (1) : increment k
    k := k + 1;

      // Step (2) : multiply a by the value f(k-1), 
      //   which is x, so that afterwards a = fProduct(k)
    a := a * x;

      // Step (3) : shift (x,y,z) forward by 1 
      //   Currently (wrt the updated k), we have:
      //     (x, y, z) = (f(k-1), f(k), f(k+1))
      //   We need to update (x,y,z) to:
      //     (x, y, z) = (f(k), f(k+1), f(k+2))
      //   using f's recurrence, in order to restore
      //   the invariant at the next loop entry.
      //   Here we perform these updates sequentially
    z := 2 * z + 3 * y - x;
    y := (z - 3 * y + x) / 2;
    x := (z - 2 * y + x) / 3;
  } 
  
  /* Loop exit: k >= n and 0 <= k <= n ⇒ k == n
    
     Invariant gives:
       a == fProduct(k) == fProduct(n)
    
     Hence, a is the product of the first n values of f,
     as intended.
  */
}

/* Alternatively, the following loop body can be used:
  
  k := k + 1;
  a := a * x;
  z, y, x := 2 * z + 3 * y - x, z, y;

  It is equivalent to the loop body above, 
  but more concise. Here the triple assignment
  expresses the intended parallel update directly:
    (x,y,z) := (f(k), f(k+1), f(k+2))
*/
