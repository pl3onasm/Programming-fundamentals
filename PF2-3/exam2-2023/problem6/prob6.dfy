/* file: prob6.dfy
   author: your name
   description: 2-3rd exam 2023, problem 6
*/

ghost function f(n: nat): int {
  if n <= 1 then n else 2 * f(n - 1) + 3 * f(n - 2)
}

ghost function fSum(n: nat): int {
  // give the body of this function
  // it should return Sum(i: 0<=i<n: f(i))
  
  // implement yourself
}

method problem6(n: nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y;
  a, k, x, y := ?, ?, ?, ?;   // initialize these variables
  
  while k < n
    invariant 0 <= k <= n && x == f(k) 
              && y == f(k + 1) && a == fSum(k)
  {
    k := k + 1;
    // complete the rest of this method
    a := ?;
    y := ?;
    x := ?;
  }
}