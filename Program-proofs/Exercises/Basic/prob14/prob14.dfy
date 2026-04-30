/* file: prob14.dfy
   author: your name
   description: extra practice in Dafny, basic, prob14  
   This is exercise 5.15 from the PC reader
*/

const n:int

method problem14(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r >= n && (r == 2 * X - n || r == 3 * n - 2 * X + 1)
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}