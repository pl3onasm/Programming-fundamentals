/* file: sol5.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 5
*/

ghost function f(a: nat, b:nat): nat {
  /* Returns b^a. This is a recursive version of  
     the exponentiation by squaring algorithm,  
     where a is the exponent and b is the base */
  if a == 0 
  then 1 
  else if a % 2 == 0 
         // even exponent: b^a = (b*b)^(a/2)
       then f(a / 2, b * b)
         // odd exponent:  b^a = b * b^(a-1)
       else b * f(a - 1, b)
}

method problem5(a: nat, b: nat) returns (r: nat)
ensures r == f(a, b)
{ 

  /* 
    Idea:
    We want to compute f(a, b) = b^a iteratively.
    The definition of f is recursive, so we will gradually
    expand it according to its definition, while maintaining
    an invariant that relates the current state of the 
    computation to the original parameters a and b.

    Seeing that each expansion of f reduces the exponent a,
    and either squares the base b (for even a) or multiplies
    the recursive call by b (for odd a), we keep track of:
      - the remaining exponent i that we still need to process,
      - the current base z that corresponds to b raised to
        the power of the reductions done so far
      - an accumulated result r that multiplies the factors
        obtained from the odd exponent cases

    Hence, we maintain the following invariant:

        r * f(i, z) == f(a, b)

    At the end we want i = 0, so that f(i, z) = f(0, z) = 1
    and thus r * 1 = f(a, b), the desired result.

    We initialise as follows: i = a, z = b, r = 1.
      So r * f(i, z) = 1 * f(a, b) = f(a, b)
      and the invariant holds at the start.
  */

  r := 1;
  var i: nat, z: nat := a, b;
  
  while i > 0
    invariant 0 <= i <= a
    invariant r * f(i, z) == f(a, b)
    decreases i
  {
    if (i % 2 == 0) { 
        /* Case 1: i is even (and > 0)
          
          From the definition of f:
            f(i, z) = f(i/2, z*z)
        
          Using the invariant:
            r * f(i, z) = f(a, b)
            r * f(i, z) = r * f(i/2, z*z)
        
          If we now set:
            z' = z * z
            i' = i / 2
        
          and leave r unchanged, we get:
            r * f(i', z') 
              = r * f(i/2, z*z) 
              = r * f(i, z) 
              = f(a, b)
          so the invariant is preserved
        */
      z := z * z;
      i := i / 2;
      
    } else {           
        /* Case 2: i is odd.
          
          From the definition of f:
            f(i, z) = z * f(i - 1, z)
        
          Using the invariant:
            r * f(i, z) = f(a, b)
            r * f(i, z) = r * (z * f(i - 1, z))
                        = (r * z) * f(i - 1, z)
        
          If we now set:
            r' = r * z
            i' = i - 1
        
          and keep z' = z, then:
            r' * f(i', z') 
              = (r * z) * f(i - 1, z)
              = r * f(i, z)
              = f(a, b)
          so the invariant is preserved
        */
      r := r * z;
      i := i - 1;
    }
  }

  /* At loop exit: i == 0
     The invariant is then:
       r * f(0, z) = f(a, b)
     Since f(0, z) = 1, we have r * 1 = f(a, b), 
     so r == f(a, b), and the postcondition holds.
  */
}

