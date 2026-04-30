/* file: sol02.dfy
   author: David De Potter
   description: extra practice in Dafny, basic,
   solution to prob02
   This is exercise 5.1b from the PC reader
*/

method problem02(x:int, ghost X:int) returns (r:int)
requires x == X
ensures  r == 5 * X - 7
{
    // P: x = X
    //   ( Multiply both sides by 5 )
    // 5 * x = 5 * X
    //   ( Subtract 7 from both sides )
    // 5 * x - 7 = 5 * X - 7
  r := 5 * x - 7;
    // Q: r = 5 * X - 7
}