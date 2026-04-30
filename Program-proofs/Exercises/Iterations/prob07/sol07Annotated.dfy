/* file: sol07Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob07, with annotations
*/

ghost function f(i:nat, x:nat, y:nat):nat
{
  match i
  case  0 => 0
  case  1 => 1
  case  _ => x * f(i - 2, x, y) + y * f(i - 1, x, y)
}

method problem07(n:nat, x:nat, y:nat) returns (r:nat)
ensures r == f(n, x, y)
{
    // Initialization to make the invariant hold at the start of the loop
    // P: 0 ≤ n
    //   ( use base cases of f )
    // 0 ≤ 0 ≤ n ∧ 0 = f(0, x, y) ∧ 1 = f(1, x, y)
  var a , b, i := 0, 1, 0;
    // J: 0 ≤ i ≤ n ∧ a = f(i, x, y) ∧ b = f(i + 1, x, y)

  while i != n       // B
    invariant 0 <= i <= n && a == f(i, x, y) && b == f(i + 1, x, y) // J
    decreases n - i  // J ∧ B ⇒ vf = n - i > 0
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ i ≤ n ∧ a = f(i, x, y) ∧ b = f(i + 1, x, y) ∧ i ≠ n ∧ n - i = V
      // 0 ≤ i < n ∧ a = f(i, x, y) ∧ b = f(i + 1, x, y) ∧ n - i = V
      //   ( prepare i := i + 1, so we need to rewrite invariant J in terms
      //     of i + 1 and i + 2; we calculate f(i + 2, x, y) using the def of f
      //     f(i + 2, x, y) = x * f(i, x, y) + y * f(i + 1, x, y) = x * a + y * b )
    var c := x * a + y * b;
      // 0 ≤ i + 1 ≤ n ∧ b = f(i + 1, x, y) ∧ n - (i + 1) < V ∧ c = f(i + 2, x, y)
    a := b;
      // 0 ≤ i + 1 ≤ n ∧ a = f(i + 1, x, y) ∧ n - (i + 1) < V ∧ c = f(i + 2, x, y)
    b := c;
      // 0 ≤ i + 1 ≤ n ∧ a = f(i + 1, x, y) ∧ n - (i + 1) < V ∧ b = f(i + 2, x, y)
    i := i + 1;
      // 0 ≤ i ≤ n ∧ a = f(i, x, y) ∧ b = f(i + 1, x, y) ∧ n - i < V
      // The invariant holds again, and vf has decreased.
  }

    // J ∧ ¬B
    // 0 ≤ i ≤ n ∧ a = f(i, x, y) ∧ b = f(i + 1, x, y) ∧ i = n
    // a = f(n, x, y) ∧ b = f(n + 1, x, y)
  r := a;
    // Q: r = f(n, x, y)
}
