/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 2
*/

method problem2(a: int, b: int) returns (r: int, s: int)
requires a % 2 == b % 2
ensures r + s == a && r - s == b
{
    //  (if a % 2 == 0, then a and b are both even, 
    //     and their sum and difference are also even
    //   if a % 2 != 0, then a and b are both odd,
    //     but their sum and difference are again even
    //   thus, (a + b) and (a - b) are always even, 
    //   meaning there exist integers k and l such that 
    //   the below expression holds)
    // a + b == 2 * k && a - b == 2 * l
    //   (divide both equalities by 2)
    // (a + b) / 2 == k && (a - b) / 2 == l
    //   (now we set r := k and s := l)

  r := (a + b) / 2;
  s := (a - b) / 2;

    //   (verify the postcondition)
    // r + s == (a + b) / 2 + (a - b) / 2
    //       == (a + b + a - b) / 2
    //       == (2 * a) / 2
    //       == a
    // r - s == (a + b) / 2 - (a - b) / 2
    //       == (a + b - a + b) / 2
    //       == (2 * b) / 2
    //       == b

  assert r + s == a && r - s == b;
}
