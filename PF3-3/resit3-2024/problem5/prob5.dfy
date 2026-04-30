/* At several locations in the file, there are question marks.
Replace the questions marks by expressions, such that Dafny 
accepts the program fragment. Note that you are not allowed to 
add or remove program statements, or change pre/post-conditions. 
However, you are allowed to insert assert statements if needed.
*/

method problem5(x: int, y: int) returns (z: int)
requires y >= 0
ensures z == x * y
{
  var a := x;
  var b := y;
  z := 0;

  while ??
    invariant ??
  {
    if ?? 
    {
      z := ??;
      b := b - 1;
    }
    
    b := b / 2;
    a := 2 * a;
  }
}
