/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 2
*/

method problem2(a: int, b: int) returns (r: int, s: int)
requires a % 2 == b % 2
ensures r + s == a && r - s == b
{
    // r + s == a && r - s == b
    //    (add the two equalities)
    // 2*r == a + b
    // r == (a + b) / 2
  r := (a + b) / 2;
    //    (substitute r into the 2nd equality)
    // (a + b) / 2 - s == b
    //    (isolate s)
    // s == (a + b) / 2 - b
    // s == (a - b) / 2
  s := (a - b) / 2;
  assert r + s == a && r - s == b;
}
