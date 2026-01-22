/* 
  file: sol5.dfy
  author: David De Potter
  description: 3-3rd exam 2026, solution to problem 5
*/

method square(n: nat) returns (s: nat)
ensures s == n * n
{
  s := 0;
  var i   := 0;
  var odd := 1;

  while (i < n)
  invariant 0 <= i <= n && odd == 2 * i + 1 && s == i * i 
  {
    s   := s + odd;
    odd := odd + 2;
    i   := i + 1;
  }
}