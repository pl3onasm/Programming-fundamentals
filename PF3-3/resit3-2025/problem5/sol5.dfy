/* 
  file: sol5.dfy
  author: David De Potter
  description: 3-3rd resit 2025, solution to problem 5
*/

method mod3(x: nat) returns (m: nat)
  ensures m == x % 3
{
  var n : nat;
  n := x;
  m := 0;
  
  while (n > 0) 
  invariant m < 3 && (m + n) % 3 == x % 3
  {
    m := (m + n % 10) % 3;
    n := n / 10;
  }
}
