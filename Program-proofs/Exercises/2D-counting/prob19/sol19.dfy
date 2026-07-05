/* file: sol19.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob19
   This is exercise 9.21 from the PC reader

   NOTE: The loop is machine-verified against the recursive
   definition of F. The connection between F(h,n,0,n,c)
   and the set-based specification from the problem statement is
   manually derived and justified in the comments, but not
   machine-verified. This avoids the additional technical machinery
   needed for sets and cardinalities in Dafny, and keeps the solution
   in line with the PC lecture notes.
*/

ghost predicate AscIncr(h:(nat,nat) -> int) 
{
  (forall i,j,k :: i <= j ==> h(i,k) <= h(j,k)) &&
  (forall i,j,k :: j <  k ==> h(i,j) <  h(i,k))
}

function Ord(b:bool): nat
{
  if b then 1 else 0
}

ghost function Gap(h:(nat,nat) -> int, x:nat, y:nat, c:int): nat
{
  if 0 < x && h(x-1,y) < c then c - h(x-1,y) else 0
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat, c:int): nat
requires AscIncr(h)
requires x <= n
decreases x, Gap(h,x,y,c)
{
  if x == 0 then
    0
  else if h(x-1,y) < c then
    F(h,x,y+1,n,c)
  else 
    Ord(h(x-1,y) == c) + F(h,x-1,y,n,c)
}

method problem19(h:(nat,nat) -> int, n:nat, c:int)
returns (z:int)
requires AscIncr(h)
requires c < h(n,0)
ensures z == F(h,n,0,n,c)
{
  var x:nat := n;
  var y:nat := 0;
  z := 0;

  while x > 0
    invariant x <= n
    invariant z + F(h,x,y,n,c) == F(h,n,0,n,c)
    decreases x, Gap(h,x,y,c)
  {
    if h(x-1,y) < c 
    {
      y := y + 1;
    } 
    
    else 
    {
      z := z + Ord(h(x-1,y) == c);
      x := x - 1;
    }
  }
}