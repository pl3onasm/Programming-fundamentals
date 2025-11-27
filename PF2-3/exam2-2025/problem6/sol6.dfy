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
  if n == 0 then 0 else f(n - 1) + fSum(n - 1)
}

method problem6(n:nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y, z;
  a, k, x, y, z := 0, 0, 0, 1, 1;
  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k + 1) 
              && z == f(k + 2) && a == fSum(k)
  {
    k := k + 1;
    a := a + x;         // add f(k) to the running sum
      
    if k % 2 == 0 {     // k even: f(k+2) = 1 + f(k)
      x := y;           // x = f(k+1)
      y := z;           // y = f(k+2)
      z := 1 + x;       // z = f(k+3) = 1 + f(k+1)

    } else {            // k odd: f(k+2) = f(k+1) + f(k-1)
      var oldX := x;    // oldX = f(k)
      x := y;           // x = f(k+1)
      y := z;           // y = f(k+2)
      z := z + oldX;    // z = f(k+2) + f(k) = f(k+3)
    }
  }
}

/* Alternatively, the following loop body  can be used:
  
  k := k + 1;
  a := a + x;
  if k % 2 == 0 {
    x, y, z := y, z, 1 + y;
  } else {
    x, y, z := y, z, z + x;
  }

  It is equivalent to the loop body above, 
  but more concise.
*/