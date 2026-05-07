/* file: sol04.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob04
   This is exercise 7.4 from the PC reader
*/

method problem04(x:nat) returns (y:int)
ensures y >= 0 && y * y <= x < (y + 1) * (y + 1)
{
  var z := x + 1;
  y := 0;

  while y + 1 < z
    invariant 0 <= y < z && y * y <= x < z * z
    decreases z - y
  {
    var m := (y + z) / 2;
    
    if m * m <= x 
    {
      y := m;
    } 
    
    else 
    {
      z := m;
    }
  }
}