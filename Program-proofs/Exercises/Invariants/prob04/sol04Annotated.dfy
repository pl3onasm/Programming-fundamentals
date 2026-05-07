/* file: prob04Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
    solution to prob04, with annotations
   This is exercise 7.4 from the PC reader
*/

method problem04(x:nat) returns (y:int)
ensures y >= 0 && y * y <= x < (y + 1) * (y + 1)
{   
    // Initialization to establish J before the loop
    // P: true
    //   ( x is a natural number, so x ≥ 0 )
    // 0 ≤ 0 < x + 1 ∧ 0 * 0 ≤ x < (x + 1) * (x + 1)
  var z := x + 1;
  y := 0;
    // J: 0 ≤ y < z ∧ y * y ≤ x < z * z

  while y + 1 < z
    invariant 0 <= y < z && y * y <= x < z * z
    decreases z - y   // J ∧ B ⇒ vf = z - y > 0
  { 
      // J ∧ B ∧ vf = V
      // 0 ≤ y < z ∧ y * y ≤ x < z * z ∧ y + 1 < z ∧ z - y = V
      //   ( since y + 1 < z and y, z are integers, we have
      //     y + 2 <= z. Hence 2 * y + 2 <= y + z, so
      //     y + 1 <= (y + z) / 2. Therefore:
      //       y < (y + z) / 2
      //     Also, since y < z, we have y + z < 2 * z, and
      //     therefore: (y + z) / 2 < z )
      // 0 ≤ y < (y + z) / 2 < z ∧ y * y ≤ x < z * z ∧ z - y = V
    var m := (y + z) / 2;
      // 0 ≤ y < m < z ∧ y * y ≤ x < z * z ∧ z - y = V
    
    if m * m <= x 
    {
        // 0 ≤ y < m < z ∧ y * y < m * m ≤ x < z * z ∧ z - y = V > z - m
      y := m;
        // 0 ≤ y < z ∧ y * y ≤ x < z * z ∧ z - y < V
    } 
    
    else 
    {
        // 0 ≤ y < m < z ∧ y * y ≤ x < m * m < z * z ∧ z - y = V > m - y
      z := m;
        // 0 ≤ y < z ∧ y * y ≤ x < z * z ∧ z - y < V
    }

      // collect branches:
      // 0 ≤ y < z ∧ y * y ≤ x < z * z ∧ z - y < V
      //   J is preserved, and the variant function has decreased
  }

    // J ∧ ¬B
    // 0 ≤ y < z ∧ y * y ≤ x < z * z ∧ y + 1 ≥ z
    //   ( since y + 1 ≥ z and y < z, we have y + 1 = z )
    // 0 ≤ y < z ∧ y * y ≤ x < z * z ∧ y + 1 = z
    // Q: y ≥ 0 ∧ y * y ≤ x < (y + 1) * (y + 1)
}


/*
   In contrast to the solution to prob03, where we had a simple linear search
   for the integer square root of x, here we have a binary search. We start
   with the interval [0, x + 1) that contains the integer square root of x
   and repeatedly cut the interval in half until we have found the integer 
   square root. Therefore, this method is in O(log x), which is much faster
   than the O(√x) method for prob03.
*/