/* At several locations in the file, there are question marks.
Replace the questions marks by expressions, such that Dafny 
accepts the program fragment. Note that you are not allowed to 
add or remove extra statements, or change pre/post-conditions. 
You are only allowed to replace the question marks by suitable 
expressions
*/

function fac(n: nat): nat
  requires n >= 0
{
  if n == 0 then 1 else n*fac(n-1)
}
 
method factorial(n: nat) returns (f: nat)
  ensures f == fac(n)
{
  f := ??;
  var i := ??;
  
  while (??) 
    invariant ??
  {
    var v,j := f,0;

    while (??) 
      invariant ??
    {
      f := f + v;
      j:= j + 1;
    }

    i := i + 1;
  }
}

