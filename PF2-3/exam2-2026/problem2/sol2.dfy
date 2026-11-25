/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd exam 2026, solution to problem 2
*/

method problem2(a: int) returns (r: int, s: int)
  requires a % 3 == 0
  ensures r - s == a
  ensures r == 4*s
{
    // a % 3 == 0
    //   ( There exists an integer s such that a = 3*s )
    // a = 3*s
    // s = a / 3
  s := a / 3;
    // r = 4*s
  r := 4 * s;
    // r - s = 4*s - s = 3*s = a
    //   ( both postconditions are satisfied )
}
