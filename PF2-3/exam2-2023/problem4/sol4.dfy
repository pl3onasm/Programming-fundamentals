/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 4
*/

method problem4(a: int, b: int, c: int) returns (i: int, j: int, k: int)
requires a <= b <= c
ensures i == j == k
{
  i, j, k := a, b, c;
  
  while i < j || j < k
  invariant i <= k && j <= k
  decreases 2 * k - i - j
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