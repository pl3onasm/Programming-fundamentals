/* file: sol07.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob07
   This is exercise 9.8 from the PC reader
*/

ghost predicate AscAsc(f:(nat,nat) -> int) 
{
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat): int
requires AscAsc(h)
decreases n - x + y
{
  if x >= n || y == 0 then 0
  else if h(x, y - 1) <= 0 
       then F(h, x + 1, y, n)
       else if x + y <= n
            then F(h, x, y - 1, n) + n - x - y + 1
            else F(h, x, y - 1, n)
}

method problem07(h:(nat,nat) -> int, n:nat) 
returns (z: int)
requires AscAsc(h)
ensures z == F(h,0,n,n)
{
  var x, y := 0, n;
  z := 0;

  while x < n && y > 0
  invariant z + F(h,x,y,n) == F(h,0,n,n)
  decreases n - x + y
  {   
    if h(x, y - 1) <= 0 
    {
      x := x + 1;
    }

    else 
    {
      if x + y <= n
      {
        z := z + n - x - y + 1;
      }

      y := y - 1;
    }
  }
}