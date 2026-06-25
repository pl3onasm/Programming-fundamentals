/* file: sol13.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob13
   This is exercise 9.15 from the PC reader
*/

ghost predicate Pos(f: (nat) -> nat)
{
  (forall k:: f(k) > 0)
}

function ord(b:bool): nat
{
  if b then 1 else 0
}

ghost function F(f: (nat) -> nat, x: nat, y: nat, a: nat, n: nat): nat
requires Pos(f)
requires 0 < a 
decreases 2 * n - y - x
{
  if y >= n || x >= n then 0
  else if S(f,x,y) >= a 
       then F(f,x+1,y,a,n) + ord(S(f,x,y) == a)
       else F(f,x,y+1,a,n)
}

ghost function S(f: (nat) -> nat, x: nat, y: nat): nat
decreases y - x
{
  if x >= y then 0 else f(x) + S(f,x+1,y)
}

lemma IncrS(f: (nat) -> nat, x: nat, y: nat)
requires x <= y
ensures S(f,x,y+1) == S(f,x,y) + f(y)
decreases y - x
{
  if x < y 
  {
    IncrS(f,x+1,y);
  }
}

method problem13(f: (nat) -> nat, a: nat, n: nat)
returns (z: nat)
requires 0 < a && 0 < n
requires Pos(f)
ensures z == F(f,0,0,a,n)
{
  var x, y, s := 0, 0, 0;
  z := 0;

  while x < n && y < n
  invariant 0 <= x <= y <= n
  invariant z + F(f,x,y,a,n) == F(f,0,0,a,n) && s == S(f,x,y)
  decreases 2 * n - x - y
  {
    if s >= a
    {
      z := z + ord(s == a);
      s := s - f(x);
      x := x + 1;
    }

    else
    {
      IncrS(f,x,y);
      s := s + f(y);
      y := y + 1;
    }
  }
}