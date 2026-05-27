/* file: sol01.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob01
   This is exercise 9.2 from the PC reader
*/

ghost predicate AscDesc(f:(nat,nat) -> int) {
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}

method search2D(h:(nat,nat) -> int, c: int, ghost X: nat, ghost Y: nat)
returns (x: nat, y: nat)
requires AscDesc(h) && h(X,Y) == c
ensures x <= X && y <= Y && h(x,y) == c 
{
  x, y := 0, 0;

  while h(x,y) != c
  invariant x <= X && y <= Y
  decreases X - x + Y - y
  {   
    if h(x,y) < c
    {
      assert x < X;
      x := x + 1;
    } 
    
    else
    {
      assert y < Y;
      y := y + 1;
    }
  }
}