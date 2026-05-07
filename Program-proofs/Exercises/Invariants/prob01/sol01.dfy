/* file: sol01.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob01
   This is exercise 7.1 from the PC reader
*/

method problem01(n:nat) returns (x:int, y:int)
ensures x == n * n && y == n * n * n
{ 
  var k := 0;
  x := 0;
  y := 0;

  while k != n
  invariant k <= n && x == k * k && y == k * k * k
  decreases n - k
  {
    y := y + 3 * x + 3 * k + 1;
    x := x + 2 * k + 1;
    k := k + 1;
  }
}