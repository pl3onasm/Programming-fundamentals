/* file: prob19.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob19  
   This is exercise 9.21 from the PC reader
*/

ghost predicate AscIncr(f:(nat,nat) -> int) 
{
    // Expresses the property that f is ascending in its first argument
    // and increasing in its second argument, i.e.
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j < k then f(i,j) < f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <  k  ==>  f(i,j) <  f(i,k))
}                
    
method problem19(h:(nat,nat) -> int, n:nat, c:int)
returns (z:int)
requires AscIncr(h)
requires c < h(n,0)
ensures z == ???
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ which is ascending in its first
    argument and increasing in its second argument.
    
    Derive a command sequence T that satisfies the following 
    specification:
      
      const n : ℕ;
      const c : ℤ;
      var   z : ℤ;
      
        {P : c < h(n,0) ∧ Z = #{ (i,j) | h(i,j) = c }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable. Also note that the domain of i 
    and j is not explicitly bounded in the specification. From c < h(n,0) and 
    monotonicity in both arguments, it follows that all matching points must 
    satisfy i < n. Thus the first coordinate is effectively bounded. The second 
    coordinate, however, remains unbounded in the specification. This is exactly 
    where the challenge of this exercise lies: the termination proof for T cannot 
    rely on a fixed upper bound for j, but has to use the strict increase of h 
    in its second argument.

    The time complexity of T should be in O(n).
  */
} 