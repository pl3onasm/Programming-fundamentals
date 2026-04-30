/* file: prob05.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob05
   This is exercise 6.7 from the PC reader
*/

ghost function h(n:nat): nat
{
  if n == 0 then 0 else 5 * h(n/3) + n % 4
}

method problem05(n:nat) returns (r:nat)
ensures r == h(n)
{
  // Derive a command sequence that computes h(n) using iteration, 
  // and prove that it is correct. You should use the following 
  // loop invariant J:     m ≥ 0 ∧ x + y * h(m) = h(n)

  // Note that / applied on nats denotes integer division 
  
}