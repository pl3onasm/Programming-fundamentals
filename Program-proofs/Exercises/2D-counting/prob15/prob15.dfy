/* file: prob15.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob15  
   This is exercise 9.17 from the PC reader
*/

ghost predicate IncrDecr(f:(nat,nat) -> int) 
{
    // Expresses the property that f is increasing in its first
    // argument and decreasing in its second argument, i.e.
    // ∀ i,j,k ∈ ℕ:
    //   if i < j then f(i,k) < f(j,k)
    //   if j < k then f(i,j) > f(i,k)
  (forall i,j,k:: i < j  ==>  f(i,k) < f(j,k)) &&
  (forall i,j,k:: j < k  ==>  f(i,j) > f(i,k))
}               
    
method problem15(h:(nat,nat) -> int, m:nat, n:nat)
returns (z: int)
requires IncrDecr(h)
ensures z == ???
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is increasing in its first
    argument and decreasing in its second argument. 
    
    Derive a command sequence T that satisfies the following 
    specification:
      
      const w, p: ℤ;
      var   z   : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i < √p ∧ 0 ≤ j < √p ∧ i² + j² < p ∧ h(i,j) = w }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(√p).
    
  */
} 