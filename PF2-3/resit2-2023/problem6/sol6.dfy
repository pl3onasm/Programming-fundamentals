/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 6
*/

ghost function f(n: nat): int 
{
  if n <= 2 then 1 else 3*f(n-1) + 2*f(n-2) - f(n-3)
}

ghost function fProd(n: nat): int 
{
  if n == 0 then 1 else f(n-1) * fProd(n-1)
}

method problem6(n:nat) returns (r: int)
ensures r == fProd(n)
{
  var k, x, y, z;

  r, k, x, y, z := 1, 0, 1, 1, 1;

  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k+1) 
              && z == f(k+2) && r == fProd(k)
  { 
    r := r*x;
    x, y, z := y, z, 3*z + 2*y - x;
    k := k + 1;
  }
}