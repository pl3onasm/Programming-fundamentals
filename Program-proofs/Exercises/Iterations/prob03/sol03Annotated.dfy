/* file: sol03Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob03, with annotations
   This is exercise 6.5 from the PC reader
*/

ghost function f(y:int, z:int): int
{
  if y <= 0 then z else 10 * f(y/10, z) + y % 10
}

method problem03(y:int, z:int) returns (r:int)
ensures r == f(y, z)
{
    // We need an extra variable y as x is immutable
  var x := y;
    // Initialization to make the invariant hold initially
    // P: true
    // 1 * f(y,z) + 0 = f(y,z)
  var m, n := 1, 0;
    // J: m * f(x,z) + n = f(y,z)
  
  while x > 0                             // B
  invariant m * f(x,z) + n == f(y,z)      // J
  decreases x                             // J ∧ B ⇒ vf = x ≥ 0
  {
      // J ∧ B ∧ vf = V
      // m * f(x,z) + n = f(y,z) ∧ x > 0 ∧ x = V
      //   ( definition of f: f(x,z) = 10 * f(x/10, z) + x % 10 )
      // m * (10 * f(x/10, z) + x % 10) + n = f(y,z) ∧ x > 0 ∧ x = V
      // 10 * m * f(x/10, z) + m * (x % 10) + n = f(y,z) ∧ x > 0 ∧ x = V
    n := m * (x % 10) + n;
      // 10 * m * f(x/10, z) + n = f(y,z) ∧ x > 0 ∧ x = V
    m := 10 * m;
      // m * f(x/10, z) + n = f(y,z) ∧ x > 0 ∧ x = V
    x := x / 10;
      // m * f(x, z) + n = f(y,z) ∧ x ≥ 0 ∧ x < V
      // J holds after the body, and the variant funtion has decreased (x < V)
  }
  
    // J ∧ ¬B
    // m * f(x,z) + n = f(y,z) ∧ x ≥ 0 ∧ x ≤ 0
    // m * f(0,z) + n = f(y,z)
    //   ( base case of f: f(0,z) = z )
    // m * z + n = f(y,z)
  r := m * z + n;
    // Q: r = f(y,z)
}