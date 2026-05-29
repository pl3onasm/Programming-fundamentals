/* file: sol02.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob02
   This is exercise 9.3 from the PC reader
*/

ghost predicate DescAsc(f:(int,int) -> int) 
{
  (forall i,j,k :: i <= j  ==>  f(i,k) >= f(j,k)) &&
  (forall i,j,k :: j <= k  ==>  f(i,j) <= f(i,k))
}

function F(g:(int,int) -> int, x:int, y:int): int
requires DescAsc(g)
{   
  if x <= 0 || y <= 0 then 0
  else if g(x - 1, y - 1) <= 0 then F(g, x - 1, y) + y
  else F(g, x, y - 1)
}

method problem02(g:(int,int) -> int, m:int, n:int) 
returns (r: int)
requires DescAsc(g)
ensures r == F(g, m ,n)
{
  var x, y, z := m, n, 0;
  
  while x > 0 && y > 0
    invariant z + F(g, x, y) == F(g, m, n)
    decreases x + y
  {
    if g(x - 1, y - 1) <= 0
    {
      z := z + y;
      x := x - 1;
    }

    else
    {
      y := y - 1;
    }
  }

  r := z;
}