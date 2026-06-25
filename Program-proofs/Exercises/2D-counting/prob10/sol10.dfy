/* file: sol10.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob10
   This is exercise 9.12 from the PC reader
*/

ghost predicate prop(p:(int,int) -> bool)
{
  (forall i,j:: p(i,j)   ==> p(i+1,j)) &&
  (forall i,j:: p(i,j+1) ==> p(i,j))
}

ghost function F(p:(int,int) -> bool, x:nat, y:nat, m:nat): int
requires prop(p)
decreases m - x - 2 * y
{
  if x + 2 * y >= m 
  then 0
  else if p(x,y) 
       then F(p,x,y+1,m) + m - 2 * y - x
       else F(p,x+1,y,m)
}

method problem10(p:(int,int) -> bool, m:nat)
returns (z: int)
requires prop(p)
ensures z == F(p,0,0,m)
{
  var x, y := 0, 0;
  z := 0;

  while x + 2 * y < m
  invariant z + F(p,x,y,m) == F(p,0,0,m)
  decreases m - x - 2 * y
  {   
    if p(x,y) 
    {
      z := z + m - 2 * y - x;
      y := y + 1;
    }

    else 
    {
      x := x + 1;
    }
  }
}