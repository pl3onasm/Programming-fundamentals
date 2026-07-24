/* file: prob11.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob11
   This is exercise 9.13 from the PC reader on coincidence counting
*/

include "../../commonSupport.dfy"
import opened CommonFunctions
import opened MonotonicityProps           
    
method problem11(a: array<int>, b: array<int>)
returns (z: int)
requires OrderedArray(a, Incr) && OrderedArray(b, Incr)
ensures z == ???
{
  /* 
    Given is the fact that both arrays a and b are increasingly sorted.
    
    Derive a command sequence T that satisfies the following 
    specification:

      const m,n : ℕ;
      const a   : array [0..m) of ℤ;
      const b   : array [0..n) of ℤ;
      var   z   : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ a[i] = b[j] }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}