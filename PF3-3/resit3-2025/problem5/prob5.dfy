/* The method mod3 takes a natural number x, and returns the 
result x % 3 (i.e. the remainder of division of x by 3). The
algorithm is based on the following observation. If x equals 
10*n + m then the remainder equals the remainder of n + m, 
because 10*n == 9*n + n and 9 is clearly a multiple of 3.

At several locations in the code there are question marks. 
Replace the questions marks by expressions, such that Dafny
accepts the program fragment. Note that you are not allowed to 
add or remove extra statements, or change pre/post-conditions. 
You are only allowed to replace the question marks by suitable 
expressions.
*/

method mod3(x: nat) returns (m: nat)
  ensures m == x % 3
{
  var n : nat;
  n := x;
  m := ??;
  
  while (??) 
  invariant m < 3 && ??
  {
    m := ??;
    n := n / 10;
  }
}
