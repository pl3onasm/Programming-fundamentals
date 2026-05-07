/* file: prob02.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob02
   This is exercise 7.2 from the PC reader
*/

ghost function factorial(n:nat): nat
{
  if n == 0 then 1 else n * factorial(n - 1)
}

method problem02(n:nat) returns (x:nat)
ensures x == factorial(n)
{
  // Derive a command T that computes the factorial for a given
  // natural number n. Use the heuristic generalization to devise
  // the loop invariant and the loop guard.
  
}