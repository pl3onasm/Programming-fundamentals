/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 5
*/

ghost function f(n: nat): int {
  // you are not allowed to remove 'ghost', so an asignment
  // like x := f(n) is not allowed.
  if n == 0 then 0 else 2 * f(n / 7) + n % 7
}

method problem5(n: nat) returns (x: int)
ensures x == f(n)
{
  /*
    Idea:
    We want to compute f(n) iteratively. The definition of f 
    is recursive, so we will gradually expand f(n) using its 
    defining equation until we reach the base case f(0) = 0.

    Seeing that each expansion of f adds a term and scales 
    the recursive call, we keep track of:
      - the current argument k for which we still need to
        expand f(k)
      - a scaling factor y (a power of 2) that tells us how 
        much the current f(k) is scaled
      - an accumulated value x that sums up all the added 
        terms so far

    Hence, we maintain the invariant:
      f(n) = x + y * f(k)
  
    Initially:
      x = 0, y = 1, k = n
      so f(n) = 0 + 1 * f(n) holds trivially
  */

  x := 0;
  var y: int := 1;
  var k: nat := n;
  
  while k > 0
    invariant x + y * f(k) == f(n)
    decreases k
  {
    /* We know k > 0 in the loop body, so we can use 
       the defining equation:
      
         f(k) = 2 * f(k / 7) + k % 7
      
       From the invariant:
      
         f(n) = x + y * f(k)
              = x + y * (2 * f(k / 7) + k % 7)
              = (x + y * (k % 7)) + (2 * y) * f(k / 7)
      
       So if we update:
         x' = x + y * (k % 7)
         y' = 2 * y
         k' = k / 7
      
       then we get:
         f(n) = x' + y' * f(k')
       and the invariant is preserved for the updated values.
    */
    x := x + y * (k % 7);
    y := y * 2;
    k := k / 7;
  }

  /*  At this point k == 0 since the loop condition k > 0 is false
      The invariant gives:
        f(n) = x + y * f(0)
      Since f(0) = 0, we have f(n) = x, so the postcondition holds.
  */
}