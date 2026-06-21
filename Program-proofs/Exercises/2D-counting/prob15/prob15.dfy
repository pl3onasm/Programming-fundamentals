/* file: prob15.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob15  
   This is exercise 9.17 from the PC reader
*/

ghost predicate DescDesc(f:(nat,nat) -> int) 
{
    // Expresses the property that f is descending in 
    // both its arguments, i.e.
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then f(i,k) ≥ f(j,k)
    //   if j ≤ k then f(i,j) ≥ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) >= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}               
    
method problem15(h:(nat,nat) -> int, m:nat, n:nat)
returns (r: int)
requires DescDesc(h)
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is descending in
    both arguments. Also given is that h(m,0) ≤ 0 and h(0,n) ≤ 0. 
    
    Derive a command sequence T that satisfies the following 
    specification:

      var z : ℤ;
      
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