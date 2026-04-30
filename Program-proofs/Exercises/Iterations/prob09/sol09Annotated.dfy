/* file: sol09Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob09, with annotations
*/

ghost function f(n:nat):nat
ensures f(n) == n * n
{
  if n == 0 then 0
            else f(n - 1) + 2 * n - 1
}

method problem09(x:nat, ghost X:nat) returns (r:nat)
requires x == X * X
ensures  r == X
{
    // Initialization to establish the invariant J
    // P: x = X * X
    //   ( use f: f(X) = X * X )
    // x = f(X)
    //   ( arithmetic manipulation )
    // 0 ≤ X ∧ x + 0 = f(X) 
  var y := x;
  r := 0;
    // J: r ≤ X ∧ y + f(r) = f(X)

  while y != 0        // B
    invariant r <= X && y + f(r) == f(X) // J
    decreases X - r   // J ∧ B ⇒ vf = X - r > 0
  {
      // J ∧ B ∧ vf = V
      // r ≤ X ∧ y + f(r) == f(X) ∧ y ≠ 0 ∧ X - r = V
      // r < X ∧ y + f(r) == f(X) ∧ X - r = V
      //   ( prepare r := r + 1; use definition of f )
      // r < X ∧ y + f(r) == f(X) ∧ f(r + 1) == f(r) + 2 * (r + 1) - 1 ∧ X - r = V
      //    ( substitute f(r) = f(X) - y in the equation for f(r + 1) )
      // r < X ∧ y - (2 * r + 1) + f(r + 1) == f(X) ∧ X - r = V
    y := y - (2 * r + 1);
      // r < X ∧ y + f(r + 1) == f(X) ∧ X - r = V
      // r + 1 ≤ X ∧ y + f(r + 1) == f(X) ∧ X - (r + 1) < V
    r := r + 1;
      // r ≤ X ∧ y + f(r) == f(X) ∧ X - r < V
      // The invariant holds again, and vf has decreased.

    assert y == f(X) - f(r);
      // Expresses y as the remaining difference after subtracting
      // the first r odd numbers from f(X) and helps Dafny to verify 
      // the invariant after the updates to y and r.
  }

    // J ∧ ¬B
    // r ≤ X ∧ y + f(r) == f(X) ∧ y = 0
    // r ≤ X ∧ f(r) == f(X)
    // r ≤ X ∧ r * r == X * X
    //   ( since r and X are nats and r ≤ X,
    //     equality of their squares implies r = X )
    // Q: r = X
}