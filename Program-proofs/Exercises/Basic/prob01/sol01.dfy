/* file: sol01.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob01
   This is exercise 5.1a from the PC reader
*/

method problem01(x:int, ghost X:int) returns (r:int)
requires x == 5 * X - 7 
ensures  r == X
{ 
    // P: x = 5 * X - 7
    //   ( add 7 to both sides )
    // x + 7 = 5 * X
    //   ( divide both sides by 5 )
    // (x + 7) / 5 = X
  r := (x + 7) / 5;
    // Q: r = X
}