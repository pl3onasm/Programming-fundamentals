/* file: sol08.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob08
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
  var x, y := a, b;
  r := 1;

  while y != 0       
    invariant y >= 0 && r * f(x, y) == f(a, b)  
    decreases y      
  {
    if y % 2 == 0 
    {
      x := x * x;
      y := y / 2;
    } 
    
    else 
    {
      r := r * x;
      y := y - 1;
    }
  }
}