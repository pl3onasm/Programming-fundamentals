/*  file: prob18.dfy
    author: your name
    description: extra practice in Dafny, 2D-counting, prob18
    This is exercise 9.20 from the PC reader
*/

include "../../Support/Monotonicity.dfy"
include "../../Support/Math.dfy"

import opened MonotonicityProps
import opened MathSupport    
    
method problem18(f:(nat,nat) -> int, d:nat, c:int)
returns  (z: int)
requires Ordered2DNat(f, Asc, Asc)
ensures  z == ???
{
  /* 
    Given is a function f: ℕ × ℕ → ℤ that is ascending in both arguments.
    
    Derive a command sequence T that satisfies the following 
    specification:

      const d : ℕ;
      const c : ℤ;
      var   z : ℤ;
      
        {P : Z = #{ j | ∃i: j ≤ i ≤ d ∧ f(i,j) = c }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program 
    variable, whereas z (lowercase) is a program variable.

    Also note that the set-based specification in the precondition is
    equivalent to the following one, which is more convenient for
    algorithmic purposes:
      #{ j | j: 0 ≤ j ≤ d ∧ (∃ i: j ≤ i ≤ d ∧ f(i,j) = c) }
      
    Even if j is larger than d, the condition j ≤ i ≤ d is unsatisfiable,
    so such a j cannot contribute to the count. Hence the explicit bound
    0 ≤ j ≤ d can be added without changing the specification.
    
    The time complexity of T should be in O(d).
  */
}