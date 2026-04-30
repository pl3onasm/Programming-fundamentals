/* file: sol09.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob09
*/

ghost function f(n:nat):nat
ensures f(n) == n * n
{
  if n == 0 then 0
            else f(n - 1) + 2 * n - 1
}

method problem09(x:nat, ghost X:nat) returns (r:nat)
requires x == X * X
ensures  r == X
{
  var y := x;
  r := 0;

  while y != 0
    invariant r <= X && y + f(r) == f(X)
    decreases X - r
  {
    y := y - (2 * r + 1);
    r := r + 1;

    assert y == f(X) - f(r);
  }
}