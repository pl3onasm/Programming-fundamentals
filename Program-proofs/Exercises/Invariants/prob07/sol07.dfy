/* file: sol07.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob07
   This is exercise 7.8 from the PC reader
*/

ghost function f(n:nat):nat
{
  if n < 2 
    then n
    else if n % 2 == 0 
          then f(n / 2)
          else f(n / 2) + f(n / 2 + 1)
}

method problem07(n:nat) returns (r:nat)
ensures r == f(n)
{
  var x, y, k:nat := 1, 0, n;
  
  while k != 0
  invariant x * f(k) + y * f(k + 1) == f(n) && k <= n
  decreases k
  {
    if k % 2 == 0
    {
      x := x + y;
    }
    else
    {
      y := x + y;
    }

    k := k / 2;
  }
 
  r := y;
}