/* file: sol04Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob04, with annotations
   This is exercise 6.6 from the PC reader
*/

ghost function g(n:nat): nat
{
  if n == 0 then 0 else g(n/10) + n % 10
}

method problem04(n:nat) returns (r:nat)
ensures r == g(n)
{
    // We need an extra variable m since n is an input parameter 
    // and cannot be modified.
  var m := n;
    
    // Initialization to make J hold initially
    // P: n ≥ 0
    //   ( use m = n )
    // m ≥ 0 ∧ 0 + g(m) = g(n)
  r := 0;
    // J: m ≥ 0 ∧ r + g(m) = g(n)

  while m > 0                            // B               
    invariant m >= 0 && r + g(m) == g(n) // J
    decreases m                          // J ∧ B ⇒ vf = m > 0        
  {
      // J ∧ B ∧ vf = V
      // m ≥ 0 ∧ r + g(m) = g(n) ∧ m > 0 ∧ m = V
      //   ( definition of g: g(m) = g(m/10) + m % 10 )
      // m ≥ 0 ∧ r + g(m/10) + m % 10 = g(n) ∧ m > 0 ∧ m = V
      // m ≥ 0 ∧ (r + m % 10) + g(m/10) = g(n) ∧ m > 0 ∧ m = V  
    r := r + m % 10;
      // m ≥ 0 ∧ r + g(m/10) = g(n) ∧ m/10 ≥ 0 ∧ m/10 < V 
    m := m / 10;
      // m ≥ 0 ∧ r + g(m) = g(n) ∧ m ≥ 0 ∧ m < V
      // J holds after the body, and the variant funtion has decreased (m < V)
  }

    // J ∧ ¬B
    // m ≥ 0 ∧ r + g(m) = g(n) ∧ m = 0
    // r + g(0) = g(n)
    //   ( base case of g: g(0) = 0 )
    // r + 0 = g(n)
    // Q: r = g(n)
}