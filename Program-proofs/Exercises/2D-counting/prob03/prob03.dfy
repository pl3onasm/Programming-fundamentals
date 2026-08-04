/* file: prob03.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob03
   This is exercise 9.4 from the PC reader
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (z: int)
requires Ordered2DInt(h, Decr, Asc)
ensures z == ???
{
  /* 
    Given is a function h: ℤ × ℤ → ℤ that is strictly decreasing in 
    its first argument and ascending in its second argument. 
    
    Derive a command sequence T that satisfies the following 
    specification:
  
      const m,n: ℕ
      const w: ℤ
      var   z: ℤ

        {P: Z = #{ (i,j) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ h(i,j) = w } }
      T
        {Q: z = Z}

    Note that Z (uppercase) is a specification constant, not a 
    program variable, whereas z (lowercase) is a program variable. 
    The time complexity of T should be in O(m + n).
  */
}