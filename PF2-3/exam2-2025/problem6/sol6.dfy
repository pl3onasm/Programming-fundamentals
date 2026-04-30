/* file: sol6.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 6
*/

ghost function f(n: nat): int 
{
  if n <= 1 
  then n
  else if n % 2 == 0
       then 1 + f(n - 2)
       else f(n - 1) + f(n - 3)
}

ghost function fSum(n: nat): int 
{
  if n == 0 then 0 else f(n - 1) + fSum(n - 1)
}

method problem6(n:nat) returns (a: int)
ensures a == fSum(n)
{
  var k, x, y, z;

  a, k, x, y, z := 0, 0, 0, 1, 1;

  while k < n
    invariant 0 <= k <= n && x == f(k) && y == f(k + 1) 
              && z == f(k + 2) && a == fSum(k)
  {
    k := k + 1;
    a := a + x;

    if k % 2 == 0 
    {     
      x := y;           
      y := z;           
      z := 1 + x;       
    } 

    else 
    {            
      var oldX := x;    
      x := y;           
      y := z;           
      z := z + oldX;    
    }
  }
}
