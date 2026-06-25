/* file: sol04.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob04
   This is exercise 9.5 from the PC reader
*/

ghost predicate IncrIncr(f:(int,int) -> int) 
{
  (forall i,j,k:: i < j  ==>  f(i,k) < f(j,k)) &&
  (forall i,j,k:: j < k  ==>  f(i,j) < f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(g:(int,int) -> int, x:nat, y:nat, m:nat): int
requires IncrIncr(g)
decreases (m - x) + y
{   
  if x >= m || y <= 0 then 0
  else if g(x, y - 1) < y - 1 then F(g, x + 1, y, m)
  else F(g, x, y - 1, m) + ord(g(x, y - 1) == y - 1)
}

method problem04(g:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires IncrIncr(g)
ensures z == F(g, 0, n, m)
{
  var x, y := 0, n;
  z := 0;

  while x < m && y > 0
  invariant z + F(g,x,y,m) == F(g,0,n,m)
  decreases (m - x) + y
  {   
    if g(x, y - 1) < y - 1
    {   
      x := x + 1;
    }

    else
    { 
      z := z + ord(g(x, y - 1) == y - 1);
      y := y - 1;
    }
  }
}

