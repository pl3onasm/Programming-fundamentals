/* file: sol18.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob18
*/

method problem18(n:int, ghost X:int) returns (r:int)
requires X >= 0 && (3 * n == 2 - X || n == X + 2)
ensures  r == X
{
  // P: X ≥ 0 && (3 * n = 2 - X ∨ n = X + 2)
  //   (regroup terms)
  // X ≥ 0 && (2 - 3 * n = X ∨ n - 2 = X)

  if n >= 2 
  { 
      //   (first disjunct is false, since 2 - 3 * n < 0 for n ≥ 2) 
      // n - 2 = X
    r := n - 2;
      // r = X
  }

  else 
  {
      //    (second disjunct is false, since n - 2 < 0 for n < 2)
      // 2 - 3 * n = X
    r := 2 - 3 * n;
      // r = X
  }

  // Collect branches:
  // Q: r = X
   
}