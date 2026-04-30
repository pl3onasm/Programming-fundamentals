/* file: sol04.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob04
   This is exercise 5.1d from the PC reader
*/

method problem04(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires x == X + Y && y == 2 * X - 7
ensures  r == X + Y && s == Y
{ 
    // P: x = X + Y ∧ y = 2 * X - 7
    //   ( add 7 to both sides of the second conjunct )
    // x = X + Y ∧ y + 7 = 2 * X
    //   ( divide both sides of the second conjunct by 2 )
    // x = X + Y ∧ (y + 7) / 2 = X
    //   ( substitute the expression for X in the first conjunct )
    // x = (y + 7) / 2 + Y ∧ x = X + Y
    //   ( subtract (y + 7) / 2 from both sides of the first conjunct )
    // x - (y + 7) / 2 = Y ∧ x = X + Y
  s := x - (y + 7) / 2;
  r := x;
    // Q: r = X + Y ∧ s = Y  
}