/* file: sol17.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob17
*/

const n:int

method problem17(a:int, ghost X:int) returns (r:int)
requires a == 2 * X - n || a == 3 * n - 2 * X + 1
ensures  r == X
{
  // P: a = 2 * X - n ∨ a = 3 * n - 2 * X + 1
  //   (regroup terms)
  // a + n = 2 * X ∨ a + n = 2 * (2 *n - X) + 1

  if (a + n) % 2 == 0
  {   
      //   (second disjunct is false)
      // a + n = 2 * X
      //   (prepare r := (a + n) / 2)
      // (a + n) / 2 = X
    r := (a + n) / 2;
      // r = X
  }

  else 
  {   
      //   (first disjunct is false)
      // a + n = 2 * (2 * n - X) + 1
      // 2 * X = 3 * n - a + 1
      //   (prepare r := (3 * n - a + 1) / 2)
      // (3 * n - a + 1) / 2 = X
    r := (3 * n - a + 1) / 2;
      // r = X
  }

  // Collect branches:
  // Q: r = X
   
}