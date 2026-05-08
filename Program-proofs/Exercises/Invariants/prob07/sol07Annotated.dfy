/* file: prob07Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob07, with annotations
   This is exercise 7.8 from the PC reader
*/

ghost function f(n:nat):nat
{
  if n < 2 
    then n
    else if n % 2 == 0 
          then f(n / 2)
          else f(n / 2) + f(n / 2 + 1)
}

method problem07(n:nat) returns (r:nat)
ensures r == f(n)
{   
    // Initialization to establish J before the loop
    // P: True
    // f(n) = f(n) ∧ n ≤ n
    // 1 * f(n) + 0 * f(n + 1) = f(n) ∧ n ≤ n
  var x, y, k:nat := 1, 0, n;
    // J: x * f(k) + y * f(k + 1) = f(n) && k ≤ n
  
  while k != 0
  invariant x * f(k) + y * f(k + 1) == f(n) && k <= n
  decreases k   // J ∧ B ⇒ vf = k > 0
  {   
      // J ∧ B ∧ vf = V
      // x * f(k) + y * f(k + 1) = f(n) ∧ k ≤ n ∧ k = V > 0

    if k % 2 == 0
    {   
        //   ( apply the definition of f for even k )
        // x * f(k / 2) + y * [f(k / 2) + f(k / 2 + 1)] = f(n) ∧ k ≤ n ∧ k = V > 0
        //   ( prepare for updating x to x + y )
        // (x + y) * f(k / 2) + y * f(k / 2 + 1) = f(n) ∧ k ≤ n ∧ k = V > 0
      x := x + y;
        // x * f(k / 2) + y * f(k / 2 + 1) = f(n) ∧ k ≤ n ∧ k = V > 0
    }

    else
    {
       //  ( apply the definition of f for odd k )
       // x * [f(k / 2) + f(k / 2 + 1)] + y * f(k / 2 + 1) = f(n) ∧ k ≤ n ∧ k = V > 0
       //  ( prepare for updating y to x + y )
       // x * f(k / 2) + (x + y) * f(k / 2 + 1) = f(n) ∧ k ≤ n ∧ k = V > 0
      y := x + y;
       // x * f(k / 2) + y * f(k / 2 + 1) = f(n) ∧ k ≤ n ∧ k = V > 0
    }

      // collect branches:
      // x * f(k / 2) + y * f(k / 2 + 1) = f(n) ∧ k ≤ n ∧ k = V > 0
      //   ( prepare for updating k to k / 2 )
      // x * f(k / 2) + y * f(k / 2 + 1) = f(n) ∧ k / 2 ≤ n ∧ k / 2 < V
    k := k / 2;
      // x * f(k) + y * f(k + 1) = f(n) ∧ k ≤ n ∧ k < V
      //   J is preserved, and the variant function has decreased.
  }

    // J ∧ ¬B
    // x * f(k) + y * f(k + 1) = f(n) ∧ k ≤ n ∧ k = 0
    // x * f(0) + y * f(1) = f(n) ∧ 0 ≤ n
    //    ( apply the definition of f for 0 and 1 )
    // x * 0 + y * 1 = f(n)
    // y = f(n) 
  r := y;
    // r = f(n) 
}