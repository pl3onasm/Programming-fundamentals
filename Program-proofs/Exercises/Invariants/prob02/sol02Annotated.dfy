/* file: sol02Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants,
   solution to prob02, with annotations
   This is exercise 7.2 from the PC reader
*/

ghost function factorial(n:nat): nat
{
  if n == 0 then 1 else n * factorial(n - 1)
}

method problem02(n:nat) returns (x:nat)
ensures x == factorial(n)
{   
    // Initialization to establish invariant J
    // P: True
    //   ( arithmetic; n is a natural number, so n ≥ 0 )
    // 0 ≤ n ∧ 1 * factorial(n) = factorial(n)
  var k, y := n, 1;
  x := 1;
    // J: 0 ≤ k ≤ n ∧ x * factorial(k) = factorial(n)

  while k != 0
    invariant 0 <= k <= n && x * factorial(k) == factorial(n)
    decreases k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k ≤ n ∧ x * factorial(k) = factorial(n) ∧ k ≠ 0 ∧ k = V
      //   ( since k ≠ 0 and k ≥ 0, we can rewrite the condition as k > 0 )
      // k > 0 ∧ x * factorial(k) = factorial(n) ∧ k = V
      //   ( use definition of factorial for k > 0 )
      // k > 0 ∧ x * k * factorial(k - 1) = factorial(n) ∧ k = V
    x := x * k;
      // k > 0 ∧ x * factorial(k - 1) = factorial(n) ∧ k = V
      //   ( prepare to update k to k - 1 )
      // 0 ≤ k - 1 ≤ n ∧ x * factorial(k - 1) = factorial(n) ∧ k - 1 < V
    k := k - 1;
      // 0 ≤ k ≤ n ∧ x * factorial(k) = factorial(n) ∧ k < V
      //   J is preserved, and the variant function has decreased.
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ x * factorial(k) = factorial(n) ∧ k = 0
    // x * 1 = factorial(n) 
    // Q: x = factorial(n)
}