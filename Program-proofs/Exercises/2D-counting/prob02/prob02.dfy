/*  file: prob02.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob02
    This is exercise 9.3 from the PC reader
*/

include "../../commonSupport.dfy"
import opened MonotonicityProps

method problem02(g:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires Ordered2DInt(g, Desc, Asc)
ensures z == ???
{
  /* 
    Given is a function g: ℤ × ℤ → ℤ that is descending in its 
    first argument and ascending in its second argument. 
    
    Derive a command sequence T that satifies the following 
    specification:
  
      const m,n: ℕ
      var   z: ℤ

        {P: Z = #{ (i,j) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ g(i,j) ≤ 0 } }
      T
        {Q: z = Z}
    
    Note that Z (uppercase) is a specification constant, not a 
    program variable, whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}