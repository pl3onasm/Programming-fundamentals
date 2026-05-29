/* file: sol03.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob03
   This is exercise 9.4 from the PC reader
*/

ghost predicate DecrAsc(f:(int,int) -> int) 
{
  (forall i,j,k:: i <  j  ==>  f(i,k) >  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(h:(int,int) -> int, x:int, y:int, w:int): int
requires DecrAsc(h)
{  
  if x <= 0 || y <= 0 then 0
  else if h(x - 1, y - 1) < w then F(h, x - 1, y, w)
  else F(h, x, y - 1, w) + ord(h(x - 1, y - 1) == w)
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (r: int)
requires DecrAsc(h)
ensures r == F(h, m ,n, w)
{
  var x, y, z := m, n, 0;

  while x > 0 && y > 0
  invariant z + F(h, x, y, w) == F(h, m, n, w)
  decreases x + y
  {
    if h(x - 1, y - 1) < w
    {
      x := x - 1;
    }

    else
    {
      z := z + ord(h(x - 1, y - 1) == w);
      y := y - 1;
    }
  }

  r := z;
}