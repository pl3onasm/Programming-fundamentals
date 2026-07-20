/*  file: prob16.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob16  
    This is exercise 9.18 from the PC reader
*/

include "../../commonSupport.dfy"
import opened MonotonicityProps              
    
method problem16(f:(nat,nat) -> int, n:nat, w:int)
returns (z: int)
requires Ordered2DNat(f, Asc, Asc)
ensures z == ???
{
  /* 
    Given is a function f: ℕ × ℕ → ℤ that is ascending in both its arguments. 
    
    Derive a command sequence T that satisfies the following 
    specification:
      
      const n : ℕ;
      const w : ℤ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ j ∧ 2j ≤ i < n ∧ f(i,j) < w }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(n).
    
  */
} 