/* file: sol12.dfy
   author: David De Potter
   description: extra practice in Dafny, basic,
   solution to prob12
*/

method problem12(x :int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires X > Y && ((x == X && y == -2 * X + Y) || (x == Y && y == X - 2 * Y))
ensures  r == X && s == Y
{
    // P: X > Y ∧ ((x = X ∧ y = -2 * X + Y) ∨ (x = Y ∧ y = X - 2 * Y))
    //   (isolate X and Y)
    // X > Y ∧ ((x = X ∧ y + 2 * X = Y) ∨ (x = Y ∧ y + 2 * Y = X))
    //   (express X > Y in terms of x and y, using the two cases)
    // (x = X ∧ y + 2 * X = Y ∧ x > y + 2 * x) ∨ (x = Y ∧ y + 2 * Y = X ∧ y + 2 * x > x)
    //   (simplify)
    // (x = X ∧ y + 2 * X = Y ∧ x + y < 0) ∨ (x = Y ∧ y + 2 * Y = X ∧ x + y > 0)

  if x + y < 0
  {   
      //   (second disjunct is false)
      // x = X ∧ y + 2 * X = Y
    r := x;
    s := y + 2 * x;
      // r = X ∧ s = Y
  }

  else
  {   
      // x + y ≥ 0 ∧ x + y > 0 ⇒ x + y > 0
      //   (first disjunct is false)
      // x = Y ∧ y + 2 * Y = X
      //   (prepare r := y + 2 * x; s := x)
      // y + 2 * x = X ∧ x = Y
    r := y + 2 * x;
    s := x;
      // r = X ∧ s = Y
  }
    
  // Collect branches:
  // Q: r = X ∧ s = Y
  
}