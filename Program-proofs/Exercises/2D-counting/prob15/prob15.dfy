/*  file: prob15.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob15  
    This is exercise 9.17 from the PC reader
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps            
    
method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z: int)
requires Ordered2DNat(h, Incr, Decr)
ensures z == ???
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is increasing in its first
    argument and decreasing in its second argument. 
    
    Derive a command sequence T that satisfies the following 
    specification:
      
      const p : ℕ;
      const w : ℤ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: i² + j² < p ∧ h(i,j) = w }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program  
    variable, whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(√p).
    
    Note that the quarter-disk constraint i² + j² < p already implies
    i < p and j < p. The search domain may therefore equivalently be
    restricted to 0 ≤ i < p and 0 ≤ j < p. These explicit bounds are
    useful when representing the specification as a finite set in Dafny.
  */
} 

