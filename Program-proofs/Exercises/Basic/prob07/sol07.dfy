/* file: sol07.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob07
*/

method problem07(a:int, b:int, ghost X:int, ghost Y:int) returns (r:int)
requires a + b == X + Y && a * X == b * Y
ensures  r == X * X + X * Y
{
    // P: a + b = X + Y ∧ a * X = b * Y
    //   (solve for a and substitute)
    // a = X + Y - b ∧ (X + Y - b) * X = b * Y 
    //   (simplify the second conjunct)
    // a + b = X + Y ∧ X * X + X * Y = b * (X + Y)
    //   (substitute the 1st conjunct into the second)
    // X * X + X * Y = b * (a + b)
  r := b * (a + b);
    // Q: r = X * X + X * Y
  
}