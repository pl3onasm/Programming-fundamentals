/* file: sol09.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob09
   This is exercise 9.11 from the PC reader
*/

ghost function F(x:nat, y:nat, w:nat): nat
decreases w - x + y
{
  if x >= w || y == 0 
  then 0
  else if (x + 1) * (x + 1) + (y - 1) * (y - 1) < w * w 
       then F(x + 1, y, w) + y
       else F(x, y - 1, w)
} 

method problem09(w:nat) 
returns (r: nat)
ensures r == F(0,w,w)
{
  var x:nat, y:nat, z:nat := 0, w, 0;

  while x < w && y > 0
  invariant z + F(x,y,w) == F(0,w,w)
  decreases w - x + y
  {
    if (x + 1) * (x + 1) + (y - 1) * (y - 1) < w * w 
    {
      z := z + y;
      x := x + 1;
    }

    else 
    {
      y := y - 1;
    }
  }
    
  r := z;
}