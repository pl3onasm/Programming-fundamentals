/* file: prob6.dfy
   author: your name
   description: 2-3rd exam 2026, problem 6
*/

ghost function f(n: int): int
{
  if n < 2 then n
  else if n % 2 == 0
       then 2*f(n/2) + n
       else 3*f((n+1)/2) + n
}

method problem6(n: int) returns (r: int)
  requires n > 0
  ensures r == f(n)
{
  var k := n;
  var x, y, z := 1, 0, 0;

  while k > 1
    invariant 1 <= k <= n && f(n) == x*f(k) + y*f(k+1) + z
    decreases k
  {
    if k % 2 == 0
    {
      x, y, z := 2*x, 3*y, z + k*x + (k+1)*y;
    }

    else
    {
      x, y, z := 0, 3*x + 2*y, z + k*x + (k+1)*y;
    }

    k := k/2;
  }

  r := x + 4*y + z;
}