/* file: prob14.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob14  
   This is exercise 9.16a from the PC reader
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps       
    
method problem14(h:(nat,nat) -> int, m:nat, n:nat)
returns (z: int)
requires Ordered2DNat(h, Desc, Desc)
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is descending in
    both arguments. 
    
    Derive a command sequence T that satisfies the following 
    specification:

      var r : ℤ;
      
        {P : Z = Max { (i+1)⋅(j+1) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ h(i,j) > 0 }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).

    NOTE: The original exercise (9.16a) asks for the maximum over all  
    natural numbers x and y with h(x,y) > 0. The assumptions h(m,0) ≤ 0  
    and h(0,n) ≤ 0 imply, by descendingness of h in both arguments, that 
    h(x,y) ≤ 0 whenever x ≥ m or y ≥ n. Hence all positive points lie 
    inside the finite rectangle 0 ≤ x < m and 0 ≤ y < n. 
    The bounded set used in the above specification already incorporates 
    this observation.
  */
} 