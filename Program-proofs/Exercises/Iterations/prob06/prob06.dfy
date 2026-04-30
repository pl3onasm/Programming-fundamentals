/* file: prob06.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob06
*/

ghost function even (n:nat): bool
{
  n % 2 == 0
}

ghost function f(n:nat): int
{
  match n
  case  0 => 2
  case  1 => 0
  case  _ => if even(n) then f(n/2) 
                        else 6 - 3 * f(n/2) + f(n/2 + 1)
}

method problem06(n:nat) returns (r:nat)
ensures r == f(n)
{
  // Derive a command sequence that computes f(n) using iteration, 
  // and prove that it is correct. You will probably need to postulate
  // a helper lemma and use active finalization.
  // Use the following loop invariant J:   
  //   
  //    a + b * f(m) + c * f(m + 1) = f(n)

  // Note that / applied on nats denotes integer division 
  
}