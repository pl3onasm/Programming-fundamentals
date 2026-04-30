/* file: sol02Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations,
   solution to prob02, with annotations
   This is exercise 6.3 from the PC reader
*/

ghost function f(n:nat): nat
{
  if n < 2 then n else f(n - 1) + f(n - 2)
}

method problem02(k:nat) returns (x:nat)
ensures x == f(k)
{
  var n, y: nat;

    // Initialization: make the invariant J hold initially
    // P: 0 ≤ k
    //   ( use base cases of f )
    // 0 ≤ 0 ≤ k ∧ 0 = f(0) ∧ 1 = f(0 + 1)
  x, n, y := 0, 0, 1;
    // 0 ≤ n ≤ k ∧ x = f(n) ∧ y = f(n + 1)  
  

  while n != k                            // B
    invariant 0 <= n <= k                 // J
    invariant x == f(n) && y == f(n + 1)  
    decreases k - n                       // vf = k - n                      
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ n ≤ k ∧ x = f(n) ∧ y = f(n + 1) ∧ n != k ∧ k - n = V
      // 0 ≤ n < k ∧ x = f(n) ∧ y = f(n + 1) ∧ k - n = V > 0
      //   ( prepare for the next iteration: n := n + 1, so that vf decreases )
      // 0 ≤ n + 1 ≤ k ∧ x = f((n + 1) - 1) ∧ y = f(n + 1) ∧ k - (n + 1) < V
    n := n + 1;
      // 0 ≤ n ≤ k ∧ x = f(n - 1) ∧ y = f(n) ∧ k - n < V
      //   ( f(n + 1) = f(n) + f(n - 1) = y + x )
      // 0 ≤ n ≤ k ∧ x = f(n - 1) ∧ y + x = f(n + 1) ∧ k - n < V
    y := y + x;
      // 0 ≤ n ≤ k ∧ x = f(n - 1) ∧ y = f(n + 1) ∧ k - n < V
      //   ( f(n) = f(n + 1) - f(n - 1) = y - x )
      // 0 ≤ n ≤ k ∧ y - x = f(n) ∧ y = f(n + 1) ∧ k - n < V
    x := y - x;
      // 0 ≤ n ≤ k ∧ x = f(n) ∧ y = f(n + 1) ∧ k - n < V
      // J holds after the body, and the variant funtion has decreased (k - n < V)
  }

    // J ∧ ¬B
    // 0 ≤ n ≤ k ∧ x = f(n) ∧ y = f(n + 1) ∧ n = k
    // Q: x = f(k)
}