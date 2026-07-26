/*  file: prob07.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob07
    This is exercise 9.8 from the PC reader
*/

include "../../commonSupport.dfy"
import opened MonotonicityProps

method problem07(h:(nat,nat) -> int, n:nat) 
returns (z: int)
requires Ordered2DNat(h, Asc, Asc)
ensures z == ???
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is ascending in 
    both its arguments.

    Derive a command sequence T that satisfies the following 
    specification:

      const n : ℕ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i < n ∧ 0 ≤ j < n 
                                 ∧ i + j < n ∧ h(i,j) > 0 } }
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a 
    program variable, whereas z (lowercase) is a program variable. 
    The time complexity of T should be in O(n).
  */
}