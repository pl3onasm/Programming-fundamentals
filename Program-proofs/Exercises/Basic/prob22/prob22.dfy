/* file: prob22.dfy
   author: your name
   description: extra practice in Dafny, basic, prob22  
*/

method problem22(a:int, b:int, ghost X:int) returns (r:int, s:int)
requires a == X
ensures  r % 2 == 0 && s == r * r && (s == X * X || s == X * X + 2 * X + 1)
{
  // X is a specification constant and is not allowed
  // to appear in the body of this method.

  // implement yourself
   
}