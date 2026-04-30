/* file: prob17.dfy
   author: your name
   description: extra practice in Dafny, basic, prob17  
*/

const n:int

method problem17(a:int, ghost X:int) returns (r:int)
requires a == 2 * X - n || a == 3 * n - 2 * X + 1
ensures  r == X
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}