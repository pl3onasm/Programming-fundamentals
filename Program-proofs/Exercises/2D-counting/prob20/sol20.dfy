/* file: sol20Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob20, with annotations
   This is exercise 9.22 from the PC reader

   NOTE: The loop is machine-verified against the recursive
   definition of F. The connection between F(p,0,n,m)
   and the set-based specification from the problem statement is
   manually derived and justified in the comments, but not
   machine-verified. This avoids the additional technical machinery
   needed for sets and cardinalities in Dafny, and keeps the solution
   in line with the PC lecture notes.
*/

ghost predicate ConvexFirst(p:(int,int) -> bool)
{
  forall x,y,z,w:int :: p(x,w) && x <= y && y <= z && p(z,w) ==> p(y,w)
}

ghost predicate MonoSecond(p:(int,int) -> bool)
{
  forall x,y,z:int :: p(x,y) && y <= z ==> p(x,z)
}

ghost function F(p:(int,int) -> bool, x:nat, y:nat, v:nat): int
requires ConvexFirst(p)
requires MonoSecond(p)
requires x <= v
decreases (v - x) + y
{
  if x == v || y == 0 then
    0
  else if p(x,y-1) && p(v-1,y-1) then
    F(p,x,y-1,v) + (v - x)
  else if !p(x,y-1) then
    F(p,x+1,y,v)
  else
    F(p,x,y,v-1)
}

method problem20(p:(int,int) -> bool, m:nat, n:nat)
returns (z:int)
requires ConvexFirst(p)
requires MonoSecond(p)
ensures z == F(p,0,n,m)
{
  var x:nat, y:nat, v:nat := 0, n, m;
  z := 0;

  while x < v && y > 0
    invariant x <= v <= m
    invariant y <= n
    invariant z + F(p,x,y,v) == F(p,0,n,m)
    decreases (v - x) + y
  {
    if p(x,y-1) && p(v-1,y-1)
    {
      z := z + (v - x);
      y := y - 1;
    }

    else if ! p(x,y-1)
    {
      x := x + 1;
    }

    else
    {
      v := v - 1;
    }
  }
}
