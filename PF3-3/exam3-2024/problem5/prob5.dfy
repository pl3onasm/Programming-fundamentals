/* At several locations in the file, there are question marks.
Replace the questions marks by expressions, such that Dafny 
accepts the program fragment. Note that you are not allowed to 
add or remove extra statements, or change pre/post-conditions. 
You are only allowed to replace the question marks by suitable 
expressions
*/

method problem5(a: array<int>) returns (k: nat)
requires a.Length > 1 && a[0] == a[a.Length-1]
ensures 0 <= k < a.Length - 1 && a[k] >= a[k+1]
{
  var i,j := 0, a.Length-1;
  while ??
    invariant ??
    decreases ??
  {
    var m := (i + j)/2;
    if ?? {
      i := ??;
    } else {
      j := ??;
    }
  }
  k := ??;
}