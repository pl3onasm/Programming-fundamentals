/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 5
*/

ghost function f(x: nat): nat {
  // you are not allowed to remove 'ghost', so an assignment
  // like x := f(n) is not allowed.
  if x < 2 then 1
  else if x % 2 == 0 then 2 * f(x/2) + 1
  else 3 * f(x/2) - 2
}

method problem5(n: nat) returns (x: nat)
ensures x == f(n)
{ 
  /* 
    We want to compute f(n) iteratively. The function f is 
    defined recursively by:
      f(x) = 1                    if x < 2
           = 2 * f(x/2) + 1       if x >= 2 and x is even
           = 3 * f(x/2) - 2       if x >= 2 and x is odd

    The recursive calls always halve the argument (x/2),
    and each step adds or subtracts some constant multiple
    of the current scaling factor.

    To simulate this computation iteratively, we unfold f(n)
    step by step, and keep track of three things:

      • k : the current argument for the remaining call f(k).
            We start with k = n and repeatedly replace k by k/2.
      • y : a scaling factor that tells us by how much f(k)
            is multiplied in the current expansion.
      • z : an accumulated offset that collects all the constant
            terms produced along the way.

    Thus, we maintain the following invariant:
      
      f(n) == z + y * f(k)
       
    Intuitively:
      • y * f(k) accounts for the remaining recursive part,
      • z accumulates everything we have already "peeled off"
        from the recursion.

    Initially, we set:
      k := n;
      y := 1;
      z := 0;

    For these initial values, the invariant gives:
      f(n) == z + y * f(k)
           == 0 + 1 * f(n)
           == f(n),
    so it holds at the start.

    At each iteration, we use the definition of f(k) to rewrite
    the invariant and update (z, y, k) accordingly, always
    replacing f(k) by an expression in terms of f(k/2).
  */

  var k, y, z: int := n, 1, 0;
  
  while k > 0
    invariant f(n) == z + y * f(k)
    decreases k
  { 
    if k % 2 == 0 {
       /* k is even and k > 0, so k >= 2 and we are in the "even" 
         branch of f's definition:
           f(k) = 2 * f(k/2) + 1
         
         From the invariant we have:
           f(n) = z + y * f(k)
                = z + y * (2 * f(k/2) + 1)
                = z + 2*y * f(k/2) + y
                = (z + y) + (2*y) * f(k/2)

         So if we set:
           z' = z + y
           y' = 2 * y
           k' = k / 2

         then we obtain:
           f(n) = z' + y' * f(k')
         and the invariant is preserved for the new k'
      */
      z := z + y;
      y := y * 2;

    } else {
      /* k is odd. For odd k >= 1 we are in the "odd" branch 
         of f's definition:
           f(k) = 3 * f(k/2) - 2

         From the invariant:
           f(n) = z + y * f(k)
                = z + y * (3 * f(k/2) - 2)
                = z + 3*y * f(k/2) - 2*y
                = (z - 2*y) + (3*y) * f(k/2)

         So if we set:
           z' = z - 2 * y
           y' = 3 * y
           k' = k / 2

         then we again have:
           f(n) = z' + y' * f(k')
         and the invariant is preserved
      */
      z := z - 2 * y; 
      y := y * 3;
    }

      // After either branch, we halve k, matching the k' = k/2
      // from both cases above.
    k := k / 2;
  }

  /* Loop exit: k == 0.
     
     From the invariant:
       f(n) == z + y * f(0)
            == z + y * 1
            == z + y

     Hence, f(n) is equal to z + y, so we set x accordingly.
  */

  assert y > -z;  // to ensure x is nat
  x := y + z;     // active finalization
}

