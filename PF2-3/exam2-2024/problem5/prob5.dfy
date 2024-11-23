/* file: prob5.dfy
   author: your name
   description: 2-3rd exam 2024, problem 5
*/

ghost function f(x: nat): nat {
  // you are not allowed to remove 'ghost', so an assignment
  // like x := f(n) is not allowed.
  if x < 2 then 1
  else if x % 2 == 0 then 2*f(x/2) + 1
  else 3 * f(x/2) - 2
}

method problem5(n: nat) returns (x: nat)
ensures x == f(n)
{
  // implement yourself. You are required to give an invariant!
}

