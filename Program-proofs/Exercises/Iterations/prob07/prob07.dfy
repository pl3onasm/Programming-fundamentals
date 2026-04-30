/* file: prob07.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob07
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
  // Derive a command sequence that computes f(n, x, y) using iteration, 
  // and prove that it is correct. You may need active finalization.
  // Use the following loop invariant J:   
  //   
  //    0 ≤ i ≤ n ∧ a = f(i, x, y) ∧ b = f(i + 1, x, y)
  
}