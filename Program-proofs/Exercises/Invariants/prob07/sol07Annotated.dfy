/* file: sol07Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob07, with annotations
*/

ghost function f(n:nat):nat
{
  if n < 2 then n
           else if n % 2 == 0 then f(n / 2)
                              else f(n / 2) + f(n / 2 + 1)
}

method problem07(n:nat) returns (r:nat)
ensures r == f(n)
{
  // Derive a command sequence that computes f(n).
  // You should use the heuristic of generalization to find
  // a suitable loop invariant J and guard B.
  
}