/* file: prob6.dfy
   author: your name
   description: 2-3rd resit 2024, problem 6
*/

ghost function f(n: int) : int 
{
  if n <= 2 
  then n + 1
  else 2*f(n - 1) + 3*f(n - 2) - f(n - 3)
}

ghost function fProduct(n: nat): int 
{
  if n == 0 then 1 else f(n - 1) * fProduct(n - 1)
}

method problem6(n: nat) returns (a: int)
requires n >= 0
{
  var x, y, z: int;
  var k : nat;
  
  a, k, x, y, z := ?, ?, ?, ?, ?;  // initialize yourself

  while ??      // find a suitable guard
  invariant 0 <= k <= n &&  x == f(k) && y == f(k + 1) 
            && z == f(k + 2) && a == fProduct(k)
  decreases ??  // find a suitable variant function
  {
    // complete the rest of this method
    k := ?;
    a := ?;
    z := ?;
    y := ?;
    x := ?;
  } 
}
