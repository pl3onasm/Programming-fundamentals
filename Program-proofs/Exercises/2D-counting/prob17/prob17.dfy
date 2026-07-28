/*  file: prob17.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob17
    This is exercise 9.19 from the PC reader
*/

include "../../commonSupport.dfy"

import opened CommonFunctions
import opened MonotonicityProps     
    
method problem17(h:(nat,nat) -> int, m:nat, n:nat)
returns (z: int)
requires Ordered2DNat(h, Asc, Asc)
ensures z == ???
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is ascending in both arguments.
    
    Derive a command sequence T that satisfies the following 
    specification:

      const m,n : ℕ;
      const w   : ℤ;
      var   z   : ℤ;
      
        {P : Z = Min{ i + j | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ h(i,j) > w }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program 
    variable, whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}