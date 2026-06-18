/* file: sol12.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob12
   This is exercise 9.14 from the PC reader
*/

ghost predicate AscAsc(f:(int,int) -> int) 
{
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

function abs(x:int): int
{
  if x < 0 then -x else x
}

function mnm(x:int, y:int): int
{
  if x <= y then x else y
}

ghost function F(h:(int,int) -> int, x:int, y:int, z:int, m:nat, n:nat): int
requires AscAsc(h)
requires 0 < m && 0 < n
requires 0 <= x <= m
requires 0 <= y <= n
decreases m - x + y
{
  if x >= m || y <= 0 then z
  else if h(x,y-1) < 0 
       then F(h, x+1, y, mnm(z, abs(h(x,y-1))), m, n)
       else F(h, x, y-1, mnm(z, abs(h(x,y-1))), m, n)
}

method problem12(h:(int,int) -> int, m:nat, n:nat)
returns (r:int)
requires AscAsc(h)
requires 0 < m && 0 < n
ensures r == F(h,0,n,abs(h(0,0)),m,n)
{
  var x:int, y:int, z:int := 0, n, abs(h(0,0));

  while x < m && 0 < y
  invariant 0 <= x <= m
  invariant 0 <= y <= n
  invariant F(h,x,y,z,m,n) == F(h,0,n,abs(h(0,0)),m,n)
  decreases m - x + y
  {
    z := mnm(z, abs(h(x,y-1)));

    if h(x,y-1) < 0
    {
      x := x + 1;
    }

    else
    {
      y := y - 1;
    }
  }

  r := z;
}