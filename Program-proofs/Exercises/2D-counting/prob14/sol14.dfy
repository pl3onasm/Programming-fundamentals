/* file: sol14.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob14
   This is exercise 9.16a from the PC reader
*/

ghost predicate DescDesc(f:(nat,nat) -> int) 
{
  (forall i,j,k:: i <= j  ==>  f(i,k) >= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
} 

function mxm(x:int, y:int): int
{
  if x >= y then x else y
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, z:int, m:nat): int
requires DescDesc(h)
requires 0 <= x <= m
requires 0 <= y
decreases m - x + y
{
  if x >= m || y == 0 
  then z
  else if h(x, y - 1) > 0 
       then F(h, x + 1, y, mxm(z, (x + 1) * y), m)
       else F(h, x, y - 1, z, m)
}
    
method problem14(h:(nat,nat) -> int, m:nat, n:nat)
returns (z: int)
requires DescDesc(h)
ensures z == F(h,0,n,0,m)
{
  var x:nat, y:nat := 0, n;
  z := 0;

  while x < m && y > 0
  invariant 0 <= x <= m && 0 <= y <= n
  invariant F(h,x,y,z,m) == F(h,0,n,0,m)
  decreases (m - x) + y
  {
    if h(x, y - 1) > 0
    {
      z := mxm(z, (x + 1) * y);
      x := x + 1;
    }

    else
    {
      y := y - 1;
    }

  }
}