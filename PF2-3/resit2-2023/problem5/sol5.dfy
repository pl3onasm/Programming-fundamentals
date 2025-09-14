/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 5
*/

ghost function f(a: nat, b:nat): nat {
  /* Returns b^a. This is a recursive rewrite of  
     the exponentiation by squaring algorithm,  
     where a is the exponent and b is the base */
  if a == 0 
  then 1 
  else if a % 2 == 0 
       then f(a / 2, b * b)
       else b * f(a - 1, b)
}

method problem5(a: nat, b: nat) returns (r: nat)
ensures r == f(a, b)
{ 
  r := 1;
  var i: nat, z: nat := a, b;
  
  while i > 0
    invariant 0 <= i <= a
    invariant r * f(i, z) == f(a, b)
    decreases i
  {
    if (i % 2 == 0) {  // i is even
      z := z * z;
      i := i / 2;
    } else {           // i is odd
      r := r * z;
      i := i - 1;
    }
  }
}

