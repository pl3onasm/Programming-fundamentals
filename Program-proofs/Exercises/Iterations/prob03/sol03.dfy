/* file: sol03.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob03
   This is exercise 6.5 from the PC reader
*/

ghost function f(y:int, z:int): int
{
  if y <= 0 then z else 10 * f(y/10, z) + y % 10
}

method problem03(y:int, z:int) returns (r:int)
ensures r == f(y, z)
{
  var m, n, x := 1, 0, y;
  while x > 0
  invariant m * f(x,z) + n == f(y,z)
  decreases x
  {
    n := m * (x % 10) + n;
    m := 10 * m;
    x := x / 10;
  }
  
  r := m * z + n;
}