/* file: sol10.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob10
*/

ghost function f(n:int):int
{
  if n < 0 then 0 else n - 2 * f(n - 7)
}

method problem10(n:int) returns (r:int)
ensures  r == f(n)
{ 
  var x, y, k := 0, 1, n;

  while k >= 0
    invariant x + y * f(k) == f(n)
    decreases k
  {
    x := x + y * k;
    y := -2 * y;
    k := k - 7;
  }

  r := x;
}