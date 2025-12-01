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
  var i := 1;
  
  while (i <= n)
    invariant 1 <= i <= n + 1 && f == fac(i - 1)
  {
    var v, j := f, 0;

    while (j < i - 1)
      invariant 0 <= j <= i - 1 && f == v + j * fac(i - 1)
    {
      f := f + v;
      j := j + 1;
    }

    i := i + 1;
  }
}