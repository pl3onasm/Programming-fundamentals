/* file: prob04.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob04
   This is exercise 6.6 from the PC reader
*/

ghost function g(n:nat): nat
{
  if n == 0 then 0 else g(n/10) + n % 10
}

method problem04(n:nat) returns (r:nat)
ensures r == g(n)
{
  // Derive a command sequence that computes g(n) using iteration, 
  // and prove that it is correct. You should use the following 
  // loop invariant J:     m ≥ 0 ∧ r + g(m) = g(n)

  // Note that / applied on nats denotes integer division 
  
}