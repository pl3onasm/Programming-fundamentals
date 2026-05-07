/* file: sol05.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob05
   This is exercise 7.5 from the PC reader
*/

method problem05(x:nat, y:nat) returns (q:nat, r:nat)
requires y > 0
ensures  x == q * y + r && 0 <= r < y
{
  q := 0;
  r := x;

  while r >= y
    invariant x == q * y + r && 0 <= r
    decreases r
  {   
    r := r - y;
    q := q + 1;
  }
}