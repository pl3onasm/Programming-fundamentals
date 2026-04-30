/* file: prob2.dfy
   author: your name
   description: 2-3rd exam 2025, problem 2
*/

method problem2(a: int, b: int) returns (r: int, s: int)
requires a%2 == b%2
ensures r + s == a && r - s == b
{
  r := ??;
  s := ??;
}
