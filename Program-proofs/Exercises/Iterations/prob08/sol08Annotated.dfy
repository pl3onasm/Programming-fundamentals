/* file: sol08Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob08, with annotations
*/

ghost function f(x:nat, y:nat):nat
decreases y 
{
  if y == 0 then 1 
            else if y % 2 == 0 then f(x * x, y / 2) 
                               else x * f(x, y - 1)
}

method problem08(a:nat, b:nat) returns (r:nat)
ensures r == f(a, b)
{
  var x, y := a, b;

    // Initialization to make J hold at the start of the loop
    // P: 0 ≤ y
    //   ( use x = a and y = b )
    // 0 ≤ y ∧ 1 * f(x, y) == f(a, b)
  r := 1;
    // J: y ≥ 0 ∧ r * f(x, y) == f(a, b)

  while y != 0       // B
    invariant y >= 0 && r * f(x, y) == f(a, b)  // J
    decreases y      // J ∧ B ⇒ vf = y > 0
  {
      // J ∧ B ∧ vf = V
      // y ≥ 0 ∧ r * f(x, y) == f(a, b) ∧ y ≠ 0 ∧ y = V
      // y > 0 ∧ r * f(x, y) == f(a, b) ∧ y = V
      
    if y % 2 == 0 
    {
        // y % 2 == 0 ∧ r * f(x, y) == f(a, b) ∧ y > 0 ∧ y = V
        //   ( since y is even, we can rewrite it as 2 * (y/2) )
        // r * f(x, 2 * (y/2)) == f(a, b) ∧ y > 0 ∧ y = V
        //   ( using the definition of f for even y )
        // r * f(x * x, y/2) == f(a, b) ∧ y > 0 ∧ y = V
      x := x * x;
        // r * f(x, y / 2) == f(a, b) ∧ y/2 ≥ 0 ∧ y/2 < V
      y := y / 2;
        // r * f(x, y) == f(a, b) ∧ y ≥ 0 ∧ y < V
    } 
    
    else 
    {
        // ¬(y % 2 == 0) ∧ r * f(x, y) == f(a, b) ∧ y > 0 ∧ y = V
        //   ( use definition of f for odd y )
        // r * x * f(x, y - 1) == f(a, b) ∧ y > 0 ∧ y = V
      r := r * x;
        // r * f(x, y - 1) == f(a, b) ∧ y - 1 ≥ 0 ∧ y - 1 < V
      y := y - 1;
        // r * f(x, y) == f(a, b) ∧ y ≥ 0 ∧ y < V
    }
    
      // Collect branches:
      // r * f(x, y) == f(a, b) ∧ y ≥ 0 ∧ y < V
      // The invariant J holds again, and vf has decreased.
  }

    // J ∧ ¬B
    // y ≥ 0 ∧ r * f(x, y) == f(a, b) ∧ y = 0
    // r * f(x, 0) == f(a, b)
    //   ( use definition of f for y = 0 )
    // r * 1 == f(a, b)
    // Q: r == f(a, b)
}