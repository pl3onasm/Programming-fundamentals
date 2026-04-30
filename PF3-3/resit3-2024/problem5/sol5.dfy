/* 
  file: sol5.dfy
  author: David De Potter
  description: 3-3rd resit exam 2024, solution to problem 5
*/

method problem5(x: int, y: int) returns (z: int)
requires y >= 0
ensures z == x * y
{
  var a := x;
  var b := y;
  z := 0;

  while b > 0
    invariant z + a * b == x * y
    invariant b >= 0
    decreases b
  {
    if b % 2 == 1 
    {
      z := z + a;
      b := b - 1;
    }

    assert b % 2 == 0;   
    assert z + a * b == z + a * (b / 2) * 2;
    
    b := b / 2;
    a := 2 * a;
  }
}
