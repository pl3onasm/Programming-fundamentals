/* file: prob08.dfy
   author: your name
   description: extra practice in Dafny, iterations, prob08
*/

ghost function f(x:nat, y:nat):nat
decreases y
{
  if y == 0 then 1 
            else if y % 2 == 0 then f(x * x, y / 2) 
                               else x * f(x, y - 1)
}

method problem08(a:nat, b:nat) returns (r:nat)
ensures r == f(a, b)
{
  // Derive a command sequence that computes f(a, b) using iteration, 
  // and prove that it is correct. You may need active finalization.
  // Use the following loop invariant J:   
  //   
  //    r * f(x, y) == f(a, b) 
  
  // Note that / applied on nats denotes integer division.
}