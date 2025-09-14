/* file: prob5.dfy
   author: your name
   description: 2-3rd exam 2023, problem 5
*/

ghost function f(n: nat): int {
  // you are not allowed to remove 'ghost', so an asignment
  // like x := f(n) is not allowed.
  if n == 0 then 0 else 2 * f(n / 7) + n % 7
}

method problem5(n: nat) returns (x: int)
ensures x == f(n)
{
  // implement yourself. You are required to give an invariant!
}