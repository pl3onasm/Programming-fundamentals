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
    if k % 2 == 0 
    {
      x := x + y * k;
      y := y * 3;
    }

    else 
    {
      x := x + y; 
      y := y * 2;
    }

    k := k / 2;
  }
}
