/* file: prob4.dfy
   author: your name
   description: 2-3rd exam 2023, problem 4
*/


method problem4(a: int, b: int, c: int) returns (i: int, j: int, k: int)
requires a <= b <= c
ensures i == j == k
{
  i, j, k := a, b, c;
  while i < j || j < k
  invariant ?      // choose a suitable invariant
  decreases ?      // choose a suitable variant function
  {
    if i < j {
      i := i + 1;
    } else {
      if j < k {
        j := j + 1;
      } else {
        k := k + 1;
      }
    }
  }
}