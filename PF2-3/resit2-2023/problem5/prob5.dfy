/* file: prob5.dfy
   author: your name
   description: 2-3rd resit 2023, problem 5
*/

ghost function f(a: nat, b: nat): nat 
{
  if a == 0 
  then 1 
  else if a % 2 == 0 
       then f(a / 2, b * b)
       else b * f(a - 1, b)
}

method problem5(a: nat, b:nat) returns (r: nat)
ensures r == f(a, b)
{
  // implement yourself. You are required to give an invariant!
}

