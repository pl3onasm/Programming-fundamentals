/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 5
*/

ghost function f(n: int): int
{
  if n < 2 then n
  else if n % 2 == 0 
       then 3 * f(n / 2) + n
       else 2 * f(n / 2) + 1
}

method problem5(n: nat) returns (x: int)
ensures x == f(n)
{
  x := 0;
  var y: int := 1;
  var k: nat := n;
  
  while k > 0
    invariant 0 <= k <= n
    invariant f(n) == x + y * f(k)
    decreases k
  { 
    if k % 2 == 0 {
        // k is even and k > 0, so we are in the "even" 
        // branch of f's definition: f(k) = 3 * f(k/2) + k
        //
        // From the invariant:
        //   f(n) = x + y * f(k)
        //        = x + y * (3 * f(k/2) + k)
        //        = (x + y * k) + (3 * y) * f(k/2)
        // So after:
        //   x' = x + y * k
        //   y' = 3 * y
        //   k' = k / 2
        // we still have f(n) = x' + y' * f(k')
      x := x + y * k;
      y := y * 3;
    } else {
        // k is odd, so we are in the "odd" branch 
        // of f's definition:  f(k) = 2 * f(k/2) + 1
        //
        // From the invariant:
        //   f(n) = x + y * f(k)
        //        = x + y * (2 * f(k/2) + 1)
        //        = (x + y) + (2 * y) * f(k/2)
        // So after:
        //   x' = x + y
        //   y' = 2 * y
        //   k' = k / 2
        // we still have f(n) = x' + y' * f(k')
      x := x + y; 
      y := y * 2;
    }
    k := k / 2;
  }

  // When the loop terminates, k == 0, so the invariant gives:
  //   f(n) = x + y * f(0).
  // Since f(0) = 0, we get f(n) = x, so the postcondition holds.
}
