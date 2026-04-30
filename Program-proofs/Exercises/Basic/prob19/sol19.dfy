/* file: sol19.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob19  
*/

method problem19(n:int, ghost X:int) returns (r:int)
requires n == 4 * X + 7 || n == 6 * X + 4
ensures  r == X
{
  // P: n = 4 * X + 7 ∨ n = 6 * X + 4

  if n % 2 == 0
  {
      //   (first disjunct is false)
      // n = 6 * X + 4
      //   (prepare r := (n - 4) / 6)
      // (n - 4) / 6 = X 
    r := (n - 4) / 6;
      // r = X
  }

  else
  {   
      //   (second disjunct is false)
      // n = 4 * X + 7
      //   (prepare r := (n - 7) / 4)
      // (n - 7) / 4 = X 
    r := (n - 7) / 4;
      // r = X
  }

  // Collect branches:
  // Q: r = X
   
}