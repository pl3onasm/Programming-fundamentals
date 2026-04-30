/* file: sol05.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob05
   This is exercise 6.7 from the PC reader
*/

ghost function h(n:nat): nat
{
  if n == 0 then 0 else 5 * h(n/3) + n % 4
}

method problem05(n:nat) returns (r:nat)
ensures r == h(n)
{
  var m := n;
  var x, y := 0, 1;

  while m > 0                               
  invariant m >= 0 && x + y * h(m) == h(n)  
  decreases m                              
  {
    x := x + y * (m % 4);
    y := 5 * y;
    m := m / 3;
  }

  r := x;
}