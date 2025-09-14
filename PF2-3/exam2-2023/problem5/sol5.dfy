/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 5
*/

ghost function f(n: nat): int {
  // you are not allowed to remove 'ghost', so an asignment
  // like x := f(n) is not allowed.
  if n == 0 then 0 else 2 * f(n / 7) + n % 7
}

method problem5(n: nat) returns (x: int)
ensures x == f(n)
{
  x := 0;
  var y: int := 1;
  var k: nat := n;
  
  while k > 0
    invariant x + y * f(k) == f(n)
    decreases k
  {
    x := x + y * (k % 7);
    y := y * 2;
    k := k / 7;
  }
}