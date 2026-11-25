/* file: sol5.dfy
   author: David De Potter 
   description: 2-3rd exam 2026, solution to problem 5
*/
  
ghost function f(n: nat): int
{
  if n < 2 then n
  else n * f(n-1) + (n+1) * f(n-2)
}

method problem5(n: nat) returns (r: int)
  ensures r == f(n)
{
  var k: nat, x: int, y: int := 0, 0, 1;

  while k < n
    invariant 0 <= k <= n
    invariant x == f(k) && y == f(k+1)
    decreases n - k
  {
    x, y := y, (k+2) * y + (k+3) * x;
    k := k + 1;
  }

  r := x;
}
