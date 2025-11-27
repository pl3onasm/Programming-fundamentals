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
  var k, y, z: int := n, 1, 0;
  
  while k > 0
    invariant f(n) == z + y * f(k)
    decreases k
  { 
    if k % 2 == 0 {
      z := z + y;
      y := y * 2;
    } else {
      z := z - 2 * y; 
      y := y * 3;
    }
    k := k / 2;
  }
  assert y > -z;  // to ensure x is nat
  x := y + z;     // active finalization
}

