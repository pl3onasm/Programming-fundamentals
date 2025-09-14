/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd exam 2024, solution to problem 5
*/

ghost function f(x: nat): nat {
  // you are not allowed to remove 'ghost', so an assignment
  // like x := f(n) is not allowed.
  if x < 2 then 1
  else if x % 2 == 0 then 2 * f(x/2) + 1
  else 3 * f(x/2) - 2
}

method problem5(n: nat) returns (x: nat)
ensures x == f(n)
{
  x := 0;
  var y: nat := 1;
  var k: nat := n;
  var z: int := 0;
  
  while k > 0
    invariant f(n) == x + z + y * f(k)
    decreases k
  { 
    if k % 2 == 0 {
      x := x + y;
      y := y * 2;
    } else {
      z := z - 2 * y; 
      y := y * 3;
    }
    k := k / 2;
  }
  assert x + y > -z;
  x := x + y + z;   // active finalization
}

