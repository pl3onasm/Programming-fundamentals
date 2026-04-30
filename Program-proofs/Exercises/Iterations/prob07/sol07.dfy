/* file: sol07.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob07
*/

ghost function f(i:nat, x:nat, y:nat):nat
{
  match i
  case  0 => 0
  case  1 => 1
  case  _ => x * f(i - 2, x, y) + y * f(i - 1, x, y)
}

method problem07(n:nat, x:nat, y:nat) returns (r:nat)
ensures r == f(n, x, y)
{
  var a , b, i := 0, 1, 0;

  while i != n       
    invariant 0 <= i <= n && a == f(i, x, y) && b == f(i + 1, x, y) 
    decreases n - i  
  {
    var c := x * a + y * b;
    a := b;
    b := c;
    i := i + 1;
  }

  r := a;
}