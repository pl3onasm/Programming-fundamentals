/* At several locations in the file, there are question marks.
Replace the questions marks by expressions, such that Dafny 
accepts the program fragment. Note that you are not allowed to 
add or remove extra statements, or change pre/post-conditions. 
You are only allowed to replace the question marks by suitable 
expressions
*/

method square(n: nat) returns (s: nat)
ensures s == n * n
{
  s := ??;
  var i := ??;
  var odd := ??;
  while (??)
  invariant ??
  {
    s := s + ??;
    odd := odd + 2;
    i := i + 1;
  }
}