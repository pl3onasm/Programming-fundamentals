/* file: sol03.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob03
   This is exercise 7.3 from the PC reader
*/

method problem03(x:nat) returns (y:int)
ensures y >= 0 && y * y <= x < (y + 1) * (y + 1)
{
  y := 0;

  while (y + 1) * (y + 1) <= x
    invariant y >= 0 && y * y <= x
    decreases x - y    
  {
    y := y + 1;
  }
}