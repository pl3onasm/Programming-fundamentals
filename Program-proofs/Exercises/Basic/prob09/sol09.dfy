/* file: sol09.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob09
*/

method problem09(x:int, ghost X:int) returns (r:int)
requires x == 2 * X + 1 || x == -2 * X
ensures  r == X
{
    // P: x = 2 * X + 1 ∨ x = -2 * X
    
  if x % 2 == 1 
  {   
      //  (second disjunct is false)
      // x = 2 * X + 1
      //  (prepare r := (x - 1) / 2)
      // (x - 1) / 2 = X
    r := (x - 1) / 2;
      // r = X
  }

  else 
  {
      //  (first disjunct is false)
      // x = -2 * X
      //  (prepare r := -x / 2)
      // -x / 2 = X
    r := -x / 2;
      // r = X
  }

  // Collect branches:
  // Q: r = X
  
}