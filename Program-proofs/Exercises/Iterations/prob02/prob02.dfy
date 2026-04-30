/* file: prob02.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob02
   This is exercise 6.3 from the PC reader
*/

ghost function f(n:nat): nat
{
  if n < 2 then n else f(n - 1) + f(n - 2)
}

method problem02(k:nat) returns (x:nat)
ensures x == f(k)
{
  // Derive a command that for a given number k ≥ 0
  // computes the k-th Fibonacci number f(k)
  // Use the following loop invariant
  // J : 0 ≤ n ≤ k ∧ x = f(n) ∧ y = f(n + 1)
  
}