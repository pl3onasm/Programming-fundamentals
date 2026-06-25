/* file: sol05.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob05
   This is exercise 9.6 from the PC reader
*/

ghost predicate AscAsc(f:(int,int) -> int) 
{
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

ghost function F(h:(int,int) -> int, x:nat, y:nat, c:int): int
requires AscAsc(h)
decreases y - x
{   
  if x >= y then 0
  else if h(x, y - 1) <= c then F(h, x + 1, y, c) + (y - x)
  else F(h, x, y - 1, c)
}

method problem05(h:(int,int) -> int, n:nat, c:int) 
returns (z: int)
requires AscAsc(h)
ensures z == F(h, 0, n, c)
{
  var x:nat, y:nat := 0, n;
  z := 0;

  while x < y
  invariant z + F(h,x,y,c) == F(h,0,n,c)
  decreases y - x
  {   
    if h(x, y - 1) <= c
    {
      z := z + (y - x);
      x := x + 1;
    }
    
    else
    { 
      y := y - 1;
    }
  }
}