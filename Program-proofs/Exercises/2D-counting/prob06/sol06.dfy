/* file: sol06.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob06
   This is exercise 9.7 from the PC reader
*/

ghost predicate IncrDesc(f:(nat,nat) -> int) 
{
  (forall i,j,k:: i <  j  ==>  f(i,k) <  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(g:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int): int
requires IncrDesc(g)
decreases n - (x + y)
{   
  if x + y >= n then 0
  else if g(x, y) < w then F(g, x + 1, y, n, w)
  else F(g, x, y + 1, n, w) + ord(g(x, y) == w)
}

method problem06(g:(nat,nat) -> int, n:nat, w:int) 
returns (z: int)
requires IncrDesc(g)
ensures z == F(g,0,0,n,w)
{
  var x, y := 0, 0;
  z := 0;

  while x + y < n
  invariant z + F(g,x,y,n,w) == F(g,0,0,n,w)
  decreases n - (x + y)
  {   
    if g(x, y) < w
    {
      x := x + 1;
    }

    else
    {
      z := z + ord(g(x, y) == w);
      y := y + 1;
    } 
  }
}