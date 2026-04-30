/* file: sol02.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations,
   solution to prob02
   This is exercise 6.3 from the PC reader
*/

ghost function f(n:nat): nat
{
  if n < 2 then n else f(n - 1) + f(n - 2)
}

method problem02(k:nat) returns (x:nat)
ensures x == f(k)
{
  var n, y: nat := 0, 1;
  x := 0;

  while n != k
    invariant 0 <= n <= k && x == f(n) && y == f(n + 1)
    decreases k - n
  {
    n := n + 1;
    y := x + y;
    x := y - x;
  }
}