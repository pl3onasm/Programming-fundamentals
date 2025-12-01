/* file: prob5.dfy
   author: your name
   description: 2-3rd resit 2024, problem 5
*/

ghost function f(x: nat): int 
{
  // you are not allowed to remove 'ghost'.
  if x <= 2 then 1
  else if x % 3 == 0 then 3*f(x/3 + 1) + 1
  else if x % 3 == 1 then 2*f(x/3) - 1
  else 2*f(x/3 + 1) - 1
}
// Note that:
// f(1)==f(3*0+1)=2*f(0)-1=2-1=1
// f(2)==f(3*0+2)=2*f(0+1)-1=2*f(1)-1=2-1=1

method problem5(n: nat) returns (x: int)
  ensures x == f(n)
{
  var y:int, z: int, k: nat;
  x,y,z,k := ?,?,?,?;   // initialize yourself

  while ??              // choose a suitable guard
    invariant 0 <= k && x*f(k) + y == f(n)
    decreases ??        // choose a suitable variant function
  {
    var m := k/3; 
    match k % 3 
    {
      case 0 => assert 3*m == k;
                ??      // implement yourself
      case 1 => assert 3*m + 1 == k;
                ??      // implement yourself
      case 2 => assert 3*m + 2 == k;
                ??      // implement yourself
    }
  }
  
  ?? // Use active finalization (if needed)
}