/* file: sol2.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 2
*/

method problem2(a: int, b: int) returns (r: int, s: int)
requires a % 2 == b % 2
ensures r + s == a && r - s == b
{
  if a % 2 == 0
  {
      // a % 2 == 0 && a % 2 == b % 2 
      // a % 2 == 0 && b % 2 == 0
      //   (as both a and b are even integers, there 
      //    exist integers k and l such that this fact holds)
      // a == 2 * k && b == 2 * l
      //   (take their sum and difference)
      // a + b == 2 * (k + l) && a - b == 2 * (k - l)
      //   (divide both equalities by 2)
      // (a + b) / 2 == k + l && (a - b) / 2 == k - l
      //   (choose r := k + l and s := k - l)
    r := (a + b) / 2;
    s := (a - b) / 2;
      //  r + s == (a + b) / 2 + (a - b) / 2 
      //        == (2 * a) / 2 
      //        == a
      //  && 
      //  r - s == (a + b) / 2 - (a - b) / 2 
      //        == (2 * b) / 2 
      //        == b
  }
    
  else 
  {   
      // a % 2 != 0 && a % 2 == b % 2
      // a % 2 != 0 && b % 2 != 0
      //   (as both a and b are odd integers, there
      //    exist integers k and l such that this fact holds)
      // a == 2 * k + 1 && b == 2 * l + 1
      //   (take their sum and difference)
      // a + b == 2 * (k + l + 1) && a - b == 2 * (k - l)
      //   (divide both equalities by 2)
      // (a + b) / 2 == k + l + 1 && (a - b) / 2 == k - l
      //   (choose r := k + l + 1 and s := k - l)
    r := (a + b) / 2;
    s := (a - b) / 2;
      //  r + s == (a + b) / 2 + (a - b) / 2 
      //        == (2 * a) / 2 
      //        == a
      //  && 
      //  r - s == (a + b) / 2 - (a - b) / 2 
      //        == (2 * b) / 2 
      //        == b
  }

    // collect branches
  assert r + s == a && r - s == b;
}
