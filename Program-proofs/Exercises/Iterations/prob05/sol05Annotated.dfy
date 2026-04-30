/* file: sol05Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob05, with annotations
   This is exercise 6.7 from the PC reader
*/

ghost function h(n:nat): nat
{
  if n == 0 then 0 else 5 * h(n/3) + n % 4
}

method problem05(n:nat) returns (r:nat)
ensures r == h(n)
{
  var m := n;

    // Initialization to make J hold initially
    // P: n ≥ 0
    //   ( use m = n )
    // m ≥ 0 ∧ 0 + 1 * h(m) = h(n)
  var x, y := 0, 1;
    // J: m ≥ 0 ∧ x + y * h(m) = h(n)

  while m > 0                               // B
  invariant m >= 0 && x + y * h(m) == h(n)  // J
  decreases m                               // J ∧ B ⇒ vf = m > 0
  {
      // J ∧ B ∧ vf = V
      // m ≥ 0 ∧ x + y * h(m) = h(n) ∧ m > 0 ∧ m = V
      //   ( definition of h: h(m) = 5 * h(m/3) + m % 4 )
      // m ≥ 0 ∧ x + y * (5 * h(m/3) + m % 4) = h(n) ∧ m > 0 ∧ m = V
      // m ≥ 0 ∧ (x + y * (m % 4)) + 5 * y * h(m/3) = h(n) ∧ m > 0 ∧ m = V
    x := x + y * (m % 4);
      // m ≥ 0 ∧ x + 5 * y * h(m/3) = h(n) ∧ m > 0 ∧ m = V
    y := 5 * y;
      // m ≥ 0 ∧ x + y * h(m/3) = h(n) ∧ m/3 ≥ 0 ∧ m/3 < V
    m := m / 3;
      // m ≥ 0 ∧ x + y * h(m) = h(n) ∧ m ≥ 0 ∧ m < V
      // J holds after the body, and the variant funtion has decreased (m < V)
  }

    // J ∧ ¬B
    // m ≥ 0 ∧ x + y * h(m) = h(n) ∧ m = 0
    // x + y * h(0) = h(n)
    //   ( base case of h: h(0) = 0 )
    // x + y * 0 = h(n)
    // x = h(n)
  r := x;
    // Q: r = h(n)
}