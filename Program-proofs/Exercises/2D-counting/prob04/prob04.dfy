/*  file: prob04.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob04
    This is exercise 9.5 from the PC reader
*/

include "../../commonSupport.dfy"
import opened MonotonicityProps
import opened CommonFunctions

method problem04(g:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(g, Incr, Incr)
ensures z == ???
{
  /* 
    Given is a function g: ℤ × ℤ → ℤ that is strictly increasing in 
    both arguments. 
    Derive a command sequence T that satisfies the following 
    specification:
  
      const m,n: ℕ
      var   z: ℤ

        {P: Z = #{ (i,j) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ g(i,j) = j } }
      T
        {Q: z = Z}
    
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}