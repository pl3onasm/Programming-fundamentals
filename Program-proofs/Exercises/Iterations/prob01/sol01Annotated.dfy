/* file: sol01Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations,
   solution to prob01, with annotations
   This is exercise 6.2 from the PC reader
*/

method problem01(a:int, b:int, ghost X:int) returns (r:int)
requires a * b == X && b >= 0   // P
ensures  r == X                 // Q
{
    // We have to use x,y since a,b are immutable
  var x, y := a, b;

    // Initialization: make the invariant J hold initially
    // P: a * b = X ∧ b ≥ 0
    //    (use x = a, y = b)
    // x * y + 0 = X ∧ y ≥ 0
  r := 0;
    // J: x * y + r = X ∧ y ≥ 0

  while y != 0                          // B
    invariant x * y + r == X && y >= 0  // J
    decreases y                         // vf = y
  {
      // J ∧ B ∧ vf = V
      // x * y + r = X ∧ y ≥ 0 ∧ y != 0 ∧ y = V
      // x * y + r = X ∧ y = V > 0
      //   ( y = 2 * (y / 2) + y % 2; note that / on ints denotes integer division )
      // x * (2 * (y / 2) + y % 2) + r = X ∧ y = V > 0
      // 2x * (y / 2) + x * (y % 2) + r = X ∧ y = V > 0
    r := x * (y % 2) + r;
      // 2x * (y / 2) + r = X ∧ y = V > 0
    x := 2 * x;
      // x * (y / 2) + r = X ∧ y = V > 0
      // x * (y / 2) + r = X ∧ y / 2 < V ∧ y / 2 ≥ 0
    y := y / 2;
      // x * y + r = X ∧ y < V ∧ y ≥ 0
      // J holds after the body, and the variant funtion has decreased (y < V)
  }

    // J ∧ ¬B
    // x * y + r = X ∧ y ≥ 0 ∧ y = 0
    // Q: r = X
  return r;
}