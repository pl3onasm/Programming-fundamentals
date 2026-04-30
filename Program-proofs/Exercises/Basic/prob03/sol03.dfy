/* file: sol03.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob03
   This is exercise 5.1c from the PC reader
*/

method problem03(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires x == X + 3 * Y - 1 && y == Y
ensures  r == X && s == Y
{
    // P: x = X + 3 * Y - 1 ∧ y = Y
    //   ( substitute y for Y in the first conjunct to get rid of 
    //     specification constant Y )
    // x = X + 3 * y - 1 ∧ y = Y
    //   ( add 1 to both sides of the first conjunct )
    // x + 1 = X + 3 * y ∧ y = Y
    //   ( subtract 3 * y from both sides of the first conjunct )
    // x + 1 - 3 * y = X ∧ y = Y
  r := x + 1 - 3 * y;
  s := y;
    // Q: r = X ∧ s = Y
  
}