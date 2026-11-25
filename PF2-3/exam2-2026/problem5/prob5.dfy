/* file: prob5.dfy
   author: your name
   description: 2-3rd exam 2026, problem 5
*/
  
ghost function f(n: nat): int
{
  if n < 2 then n
  else n * f(n-1) + (n+1) * f(n-2)
}

method problem5(n: nat) returns (r: int)
  ensures r == f(n)
{
  // Implement yourself.
  // You are required to use a while loop with an invariant!
}
