/* file: sol02.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants,
   solution to prob02
   This is exercise 7.2 from the PC reader
*/

ghost function factorial(n:nat): nat
{
  if n == 0 then 1 else n * factorial(n - 1)
}

method problem02(n:nat) returns (x:nat)
ensures x == factorial(n)
{
  var k, y := n, 1;
  x := 1;

  while k != 0
    invariant 0 <= k <= n && x * factorial(k) == factorial(n)
    decreases k
  {
    x := x * k;
    k := k - 1;
  }
}

