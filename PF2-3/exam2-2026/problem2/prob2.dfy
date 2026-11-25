/* file: prob2.dfy
   author: your name
   description: 2-3rd exam 2026, problem 2
*/

method problem2(a: int) returns (r: int, s: int)
  requires a % 3 == 0
  ensures r - s == a
  ensures r == 4*s
{
  s := ??;
  r := ??;
}
