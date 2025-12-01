/* file: sol5Annotated.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 5
                with annotations
*/

ghost function f(n: int): int
{
    // Returns the value of the recursive function f at n
  if n < 2 then n
  else if n % 2 == 0 
       then 3 * f(n / 2) + n
       else 2 * f(n / 2) + 1
}

method problem5(n: nat) returns (x: int)
ensures x == f(n)
{
  /* 
    We want to compute f(n) iteratively. The definition of f 
    is recursive, so we will gradually expand f(n) using its
    definition until we reach the base case.

    Seeing that each expansion of f adds a term (either n or 1), 
    and scales the recursive call (either by 2 or by 3), 
    we keep track of:
      • the current argument k for which we still need to
        expand f(k)
      • a scaling factor y that tells us how much the current 
        f(k) is scaled
      • an accumulated value x that sums up all the added 
        terms so far

    Hence, we maintain the invariant:
      
      f(n) == x + y * f(k)

    Intuitively:
      • y * f(k) accounts for the remaining recursive part
      • x accumulates everything we have already "peeled off"
        from the recursion
       
    Initially, k = n, y = 1, x = 0, so the invariant gives:
      f(n) == 0 + 1 * f(n), i.e. f(n) == f(n), which holds.
       
     At each step, we halve k. Depending on whether k is even 
     or odd, we update x and y according to f's definition.
  */
  x := 0;
  var y: int := 1;
  var k: nat := n;
  
  while k > 0
    invariant 0 <= k <= n
    invariant f(n) == x + y * f(k)
    decreases k
  { 
    if k % 2 == 0 
    {
      /* k is even and k > 0, so we are in the "even" 
          branch of f's definition: f(k) = 3 * f(k/2) + k
        
          From the invariant:
            f(n) = x + y * f(k)
                = x + y * (3 * f(k/2) + k)
                = (x + y * k) + (3 * y) * f(k/2)

          So if we update:
            x' = x + y * k
            y' = 3 * y
            k' = k / 2

          then we have again f(n) = x' + y' * f(k')
          and the invariant is maintained for the updated values.
      */
      x := x + y * k;
      y := y * 3;
    } 
    
    else 
    {
      /* k is odd, so we are in the "odd" branch 
          of f's definition:  f(k) = 2 * f(k/2) + 1
        
          From the invariant:
            f(n) = x + y * f(k)
                = x + y * (2 * f(k/2) + 1)
                = (x + y) + (2 * y) * f(k/2)

          So if we update:
            x' = x + y
            y' = 2 * y
            k' = k / 2
            
          then we have again f(n) = x' + y' * f(k')
          and the invariant is maintained for the updated values.
      */
      x := x + y; 
      y := y * 2;
    }

    // After either branch, we halve k, matching the k' = k/2
    // from both cases above.
    k := k / 2;
  }

  /* When the loop terminates, k == 0.
     The invariant gives:
       f(n) == x + y * f(0)
     Since f(0) == 0, we have:
       f(n) == x + y * 0
            == x
     so the postcondition holds.
  */
}
