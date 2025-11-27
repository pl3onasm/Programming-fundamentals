/* file: sol3.dfy
   author: David De Potter
   description: 2-3rd exam 2025, solution to problem 3
*/

method problem3(n: int) returns (a: int, b: int, c: int)
  ensures a + b + c == n
  ensures a < b + 1 < c + 2 < a + 4
{ 
  var k: int := n / 3;
  match n % 3
  {
    case 0 =>         // n == 3*k + 0
      a := k;         // a == n / 3 == k
      b := k;         // b == (n + 1) / 3 == k
      c := k;         // c == (n + 2) / 3 == k

    case 1 =>         // n == 3*k + 1
      a := k;         // a == n / 3 == k
      b := k;         // b == (n + 1) / 3 == k
      c := k + 1;     // c == (n + 2) / 3 == k + 1
      
    case 2 =>         // n == 3*k + 2
      a := k;         // a == n / 3 == k
      b := k + 1;     // b == (n + 1) / 3 == k + 1
      c := k + 1;     // c == (n + 2) / 3 == k + 1
  }
  assert a + b + c == n;
  assert a < b + 1 < c + 2 < a + 4;  
}
