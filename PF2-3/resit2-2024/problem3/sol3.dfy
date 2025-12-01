/* file: sol3.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 3
*/

method problem3(n:int, ghost X: int) returns (r:int)
requires n == X
ensures r >= 0 && (r + X == 0 || 3*r <= X + 1 < 3*(r + 1))
{
  if n < 0 
  {
    r := -n;
    assert r >= 0;
    assert r + X == 0;
  } 
  
  else 
  {
      // 3*r <= X + 1 < 3*(r + 1)
      // r <= (X + 1)/3 < r + 1
      // r == (X + 1)/3
    r := (n + 1) / 3;
    assert r >= 0;
    assert 3*r <= X + 1 < 3*(r + 1);
  }
  
    // collect branches
  assert r >= 0 && (r + X == 0 || 3*r <= X + 1 < 3*(r + 1));
}
