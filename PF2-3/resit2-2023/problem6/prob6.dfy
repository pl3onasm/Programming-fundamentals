/* file: prob6.dfy
   author: your name
   description: 2-3rd resit 2023, problem 6
*/

ghost function f(n: nat): int {
  if n <= 2 then 1 else 3*f(n-1) + 2*f(n-2) - f(n-3)
}

ghost function fProd(n: nat): int {
  // give the body of this function
  // it should return Product(i: 0<=i<n: f(i))
}

method problem6(n:nat) returns (r: int)
ensures r == fProd(n)
{
  var k, x, y, z;
  r, k, x, y, z := ?, ?, ?, ?, ?;  // initialize yourself
  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k + 1) 
              && z == f(k + 2) && r == fProd(k)
  {
    r := r*x;
    x, y, z := y, z, 3*z + 2*y - x;
    k := k + 1;
  }
}
