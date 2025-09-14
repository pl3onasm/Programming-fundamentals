/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 6
*/

ghost function f(n: int) : int {
  if n <= 2 
  then n + 1
  else 2*f(n - 1) + 3*f(n - 2) - f(n - 3)
}

ghost function fProduct(n: nat): int {
  if n == 0 then 1 else f(n - 1) * fProduct(n - 1)
}

method problem6(n: nat) returns (a: int)
requires n >= 0
{
  var x,y,z: int;
  var k : nat;
  a, k, x, y, z := 1, 0, 1, 2, 3;
  while k < n
  invariant 0 <= k <= n &&  x == f(k) && y == f(k + 1) 
            && z == f(k + 2) && a == fProduct(k)
  decreases n - k
  {
    k := k + 1;
    a := a * x;
    z := 2 * z + 3 * y - x;
    y := (z - 3 * y + x) / 2;
    x := (z - 2 * y + x) / 3;
  } 
}

/* Alternatively, the following loop body can be used:
  
  k := k + 1;
  a := a * x;
  z, y, x := 2 * z + 3 * y - x, z, y;

  It is equivalent to the loop body above, 
  but more concise.
 */
