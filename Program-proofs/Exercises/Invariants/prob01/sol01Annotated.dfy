/* file: sol01Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob01, with annotations
   This is exercise 7.1 from the PC reader
*/

method problem01(n:nat) returns (x:int, y:int)
ensures x == n * n && y == n * n * n
{ 
    // Initialization to establish invariant J
    // P: True
    //   ( arithmetic; n is a natural number, so n ≥ 0 )
    // 0 ≤ n ∧ 0 = 0 * 0 ∧ 0 = 0 * 0 * 0
  var k := 0;
  x := 0;
  y := 0;
    // J: k ≤ n ∧ x = k * k ∧ y = k * k * k

  while k != n     // B
  invariant k <= n && x == k * k && y == k * k * k
  decreases n - k  // J ∧ B ⇒ vf = n - k > 0
  {
      // J ∧ B ∧ vf = V
      // k ≤ n ∧ x = k * k ∧ y = k * k * k ∧ k ≠ n ∧ n - k = V
      //   ( since k ≠ n and k ≤ n, we can rewrite the condition as k < n )
      // k < n ∧ x = k * k ∧ y = k * k * k ∧ n - k = V
      //   ( prepare to update k to k + 1, by first updating y 
      //     to the value it should have when k is updated to k + 1 )
      // k < n ∧ x = k * k ∧ y + 3 * x + 3 * k + 1 = (k + 1) * (k + 1) * (k + 1) 
      //    ∧ n - k = V
    y := y + 3 * x + 3 * k + 1;
      // k < n ∧ x = k * k ∧ y = (k + 1) * (k + 1) * (k + 1) ∧ n - k = V
      //   ( prepare to update x to the value it should have when k 
      //     is updated to k + 1 )
      // k < n ∧ x + 2 * k + 1 = (k + 1) * (k + 1) 
      //     ∧ y = (k + 1) * (k + 1) * (k + 1) ∧ n - k = V
    x := x + 2 * k + 1;
      // k < n ∧ x = (k + 1) * (k + 1) 
      //     ∧ y = (k + 1) * (k + 1) * (k + 1) ∧ n - k = V
      //   ( prepare to update k to k + 1 )
      // k + 1 ≤ n ∧ x = (k + 1) * (k + 1) 
      //     ∧ y = (k + 1) * (k + 1) * (k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // k ≤ n ∧ x = k * k ∧ y = k * k * k ∧ n - k < V
      //   J is preserved, and the variant function has decreased.
  }

    // J ∧ ¬B
    // k ≤ n ∧ x = k * k ∧ y = k * k * k ∧ k = n
    // Q: x = n * n ∧ y = n * n * n
}