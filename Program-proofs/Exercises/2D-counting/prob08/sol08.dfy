/* file: sol08.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob08
   This is exercise 9.9 from the PC reader
*/


ghost predicate AscAsc(f:(int,int) -> int) 
{
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(h:(int,int) -> int, x:nat, y:nat, n:nat): int
requires AscAsc(h)
decreases x + (n - y)
{
  if x == 0 || y >= n then 0
  else if h(x-1,y) >= 0 
       then F(h,x-1,y,n) + ord(h(x-1,y) == 0)
       else F(h,x,y+1,n)
}

method problem08(h:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires AscAsc(h)
ensures z == F(h,m,0,n)
{
  var x:nat, y:nat := m, 0;
  z := 0;

  while x > 0 && y < n
  invariant z + F(h,x,y,n) == F(h,m,0,n)
  decreases x + (n - y)
  {
    if h(x-1,y) >= 0 
    {
      z := z + ord(h(x-1,y) == 0);
      x := x - 1;
    }

    else 
    {
      y := y + 1;
    }
  }
}