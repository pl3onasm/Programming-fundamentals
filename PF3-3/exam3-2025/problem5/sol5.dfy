/* 
  file: sol5.dfy
  author: David De Potter
  description: 3-3rd exam 2025, solution to problem 5
*/

function fac(n: nat): nat
  requires n >= 0
{
  if n == 0 then 1 else n * fac(n - 1)
}

method factorial(n: nat) returns (f: nat)
  ensures f == fac(n)
{
  f := 1;
  var i: nat := 0;

  while i < n
    invariant 0 <= i <= n && f == fac(i)
  {
    var v, j: nat := f, 0;

    while j < i
      invariant 0 <= j <= i && f == v + j * v
    {
      f := f + v;
      j := j + 1;
    }
    
    i := i + 1;       
  }
}