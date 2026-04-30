/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 6
*/

ghost function f(n: nat): int 
{
  if n <= 1 then n else 2 * f(n - 1) + 3 * f(n - 2)
}

ghost function fSum(n: nat): int 
{
  if n == 0 then 0 else f(n - 1) + fSum(n - 1)
}

method problem6(n: nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y;

  a, k, x, y := 0, 0, 0, 1;
  
  while k < n
    invariant 0 <= k <= n && x == f(k) 
              && y == f(k + 1) && a == fSum(k)
  {   
    k := k + 1;
    a := a + x;
    y := 2 * y + 3 * x;
    x := (y - 3 * x) / 2;
  }
}
