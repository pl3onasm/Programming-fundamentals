/* file: prob20.dfy
   author: your name
   description: extra practice in Dafny, basic, prob20  
*/

const n:int

method problem20(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r >= n && (x == 2 * X + 2 * n || x == -2 * X)
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}