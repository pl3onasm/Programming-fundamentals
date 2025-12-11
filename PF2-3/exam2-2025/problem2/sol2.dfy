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
      //   (as both a and b are even integers,
      //    their sum and difference are also even integers;
      //    let k and l be integers that express this fact)
      // a + b == 2 * k && a - b == 2 * l
      //   (divide both equations by 2)
      // (a + b) / 2 == k && (a - b) / 2 == l
      //   (choose r := k and s := l)
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
      //   (as both a and b are odd integers,
      //    their sum and difference are even integers;
      //    let k and l be integers that express this fact)
      // a + b == 2 * k && a - b == 2 * l
      //   (divide both equations by 2)
      // (a + b) / 2 == k && (a - b) / 2 == l
      //   (choose r := k and s := l)
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
