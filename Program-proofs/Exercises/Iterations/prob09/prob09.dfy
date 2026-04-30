/* file: prob09.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob09
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
  // Derive a command sequence S such that {P} S {Q}, 
  // where P is the precondition and Q is the postcondition.
  // Use the following loop invariant J:
  //    r ≤ X ∧ y + f(r) == f(X) 
}