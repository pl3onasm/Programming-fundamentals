/*  file: prob05.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob05
    This is exercise 9.6 from the PC reader
*/

include "../../commonSupport.dfy"
import opened MonotonicityProps

method problem05(h:(int,int) -> int, n:nat, c:int) 
returns (z: int)
requires Ordered2DInt(h, Asc, Asc)
ensures z == ???
{
  /* 
    Given is a function h: ℤ × ℤ → ℤ that is ascending in 
    both arguments. 
    Derive a command sequence T that satisfies the following 
    specification:

      const n : ℕ;
      const c : ℤ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i ≤ j < n ∧ h(i,j) ≤ c } }
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a 
    program variable, whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(n).
  */
}