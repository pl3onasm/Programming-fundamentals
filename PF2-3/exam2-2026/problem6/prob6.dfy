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
  var x, y, z := ............;  // initialize yourself
  while k > 1
    invariant 1 <= k <= n && f(n) == x*f(k) + y*f(k+1) + z
  {
    // implement yourself
    ........

    k := k/2;
  }
  r := ............;  // active finalization
}
