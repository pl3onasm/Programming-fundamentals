/* file: sol04.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob04
   This is exercise 6.6 from the PC reader
*/

ghost function g(n:nat): nat
{
  if n == 0 then 0 else g(n/10) + n % 10
}

method problem04(n:nat) returns (r:nat)
ensures r == g(n)
{
  var m:= n;
  r := 0;
  while m > 0
    invariant m >= 0 && r + g(m) == g(n)
    decreases m
  {
    r := r + m % 10;
    m := m / 10;
  }
}