/* file: prob5.dfy
   author: your name
   description: 2-3rd exam 2025, problem 5
*/

ghost function f(n: int): int
{
  if n < 2 then n
  else if n%2 == 0 
       then 3*f(n/2) + n
       else 2*f(n/2) + 1
}

method problem5(n: nat) returns (x: int)
ensures x == f(n)
{
  // implement yourself. You are required to give an invariant!
}
