/* file: sol16.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob16
   This is exercise 9.18 from the PC reader
*/

ghost predicate AscAsc(f:(nat,nat) -> int) 
{
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}                

ghost function F(f:(nat,nat) -> int, x:nat, y:nat,
                 n:nat, w:int): int
requires AscAsc(f)
requires x <= n
requires y <= n
decreases x + (n - y)
{
  if x == 0 || y == n || 2 * y >= x 
  then 0 
  else if f(x-1,y) >= w 
       then F(f,x-1,y,n,w) 
       else F(f,x,y+1,n,w) + x - 2 * y
}

method problem16(f:(nat,nat) -> int, n:nat, w:int)
returns (z: int)
requires AscAsc(f)
ensures z == F(f, n, 0, n, w)
{
  var x:nat, y:nat := n, 0;
  z := 0;

  while x > 0 && y < n && 2 * y < x
  invariant 0 <= x <= n && 0 <= y <= n
  invariant z + F(f,x,y,n,w) == F(f,n,0,n,w)
  decreases x + (n - y)
  {
    if f(x-1,y) >= w
    {
      x := x - 1;
    }

    else 
    {
      z := z + x - 2 * y;
      y := y + 1;
    }
  }
} 
