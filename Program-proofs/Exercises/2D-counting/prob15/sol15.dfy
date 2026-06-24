/* file: sol15.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob15
   This is exercise 9.17 from the PC reader
*/

ghost predicate IncrDecr(f:(nat,nat) -> int)
{
  (forall i,j,k :: i < j ==> f(i,k) < f(j,k)) &&
  (forall i,j,k :: j < k ==> f(i,j) > f(i,k))
}

function ord(b:bool): nat
{
  if b then 1 else 0
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat,
                 p:nat, w:int): int
requires IncrDecr(h)
requires x <= p
requires y <= p
decreases (p - x) + (p - y)
{
  if x == p || y == p || x * x + y * y >= p then
    0
  else if h(x,y) < w then
    F(h, x + 1, y, p, w)
  else 
    F(h, x, y + 1, p, w) + ord(h(x,y) == w)
}

method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z:int)
requires IncrDecr(h)
ensures z == F(h, 0, 0, p, w)
{
  var x:nat, y:nat := 0, 0;
  z := 0;

  while x*x + y*y < p
    invariant 0 <= x <= p
    invariant 0 <= y <= p
    invariant z + F(h, x, y, p, w) == F(h, 0, 0, p, w)
    decreases (p - x) + (p - y)
  {
    if h(x,y) < w 
    {
      x := x + 1;
    } 

    else 
    {
      z := z + ord(h(x,y) == w);
      y := y + 1;
    }
  }
}
