/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 6
*/

ghost function f(n: nat): int {
  if n <= 2 then 1 else 3*f(n-1) + 2*f(n-2) - f(n-3)
}

ghost function fProd(n: nat): int {
  // Returns the product of the first n values of f:
  //   fProd(n) = Π_{i=0}^{n-1} f(i)
  if n == 0 then 1 else f(n-1) * fProd(n-1)
}

method problem6(n:nat) returns (r: int)
ensures r == fProd(n)
{
  var k, x, y, z;

  /*  Idea:
      The function f is defined by a linear recurrence 
      of order 3:
        f(n) = 3*f(n-1) + 2*f(n-2) - f(n-3) for n > 2
        with base cases f(0) = f(1) = f(2) = 1

      We want to compute the product of the first n values
      of f in an efficient, non-recursive way. That is, we 
      want to compute: fProd(n) = Π_{i=0}^{n-1} f(i)

      For this, we iterate with a counter k, maintaining
      at the **start of each loop iteration**:
          • k = how many terms we have already 
                multiplied into r
          • r = product of f(0), ..., f(k-1),
                i.e. r == fProd(k)
          • x = f(k), y = f(k+1), z = f(k+2)

      In other words, at loop entry we have:
          (r, x, y, z, k) = (fProd(k), f(k), f(k+1), f(k+2), k)

      Inside the loop body, we perform these steps:
          (1) multiply r by f(k) (which is x), so that
              r becomes fProd(k+1)
          (2) shift (x, y, z) forward by 1 using 
              the recurrence for f, turning
                (f(k), f(k+1), f(k+2))
              into
                (f(k+1), f(k+2), f(k+3))
          (3) increment k, so that at the end of the
              iteration the invariant holds again for
              this new k

      When k reaches n, r will equal fProd(n).

      We initialise as follows:
          k = 0,
          x = f(0) = 1
          y = f(1) = 1
          z = f(2) = 1
          r = fProd(0) = 1

      So that the invariant holds at the start.
  */   

  r, k, x, y, z := 1, 0, 1, 1, 1;

  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k+1) 
              && z == f(k+2) && r == fProd(k)
  { 
      // Step (1) : multiply r by f(k) (which is x) to
      //   incorporate f(k) into the running product r
    r := r*x;

      // Step (2) : shift (x,y,z) forward by 1 
      //   using f's recurrence
    x, y, z := y, z, 3*z + 2*y - x;
    
      // Step (3) : increment k
    k := k + 1;
  }

  /* Loop exit: k >= n and 0 <= k <= n ⇒ k == n
    
     Invariant gives:
       r == fProd(k) == fProd(n)
    
     Hence, the postcondition holds.
  */
}