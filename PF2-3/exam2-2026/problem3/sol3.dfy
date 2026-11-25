/* file: sol3.dfy
   author: David De Potter
   description: 2-3rd exam 2026, solution to problem 3
*/

method problem3(n: int) returns (a: int, b: int)
  ensures -1 <= b <= 1 && n == 3*a + b
{
  var k : int := n / 3;

  match n % 3         // remainder after integer division by 3
  {
    case 0 =>         // n = 3*k + 0
      a := k;
      b := 0;

    case 1 =>         // n = 3*k + 1
      a := k;
      b := 1;

    case 2 =>         // n = 3*k + 2 = (3*k + 3) - 1 = 3*(k+1) - 1
      a := k + 1;     
      b := -1;        
  }
}
