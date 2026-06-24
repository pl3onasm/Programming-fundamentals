/* file: prob16.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob16  
   This is exercise 9.18 from the PC reader
*/

ghost predicate AscAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is ascending in 
    // both its arguments, i.e.
    // ∀ i,j,k ∈ ℤ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}                
    
method problem16(f:(nat,nat) -> int, m:nat, n:nat)
returns (r: int)
requires AscAsc(f)
ensures r == ???
{
  /* 
    Given is a function f: ℕ × ℕ → ℤ that is ascending in both its arguments. 
    
    Derive a command sequence T that satisfies the following 
    specification:
      
      const m, n, w: ℤ;
      var   z      : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i < n ∧ 0 ≤ j < n ∧ 2j ≤ i < n ∧ f(i,j) = w }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(n).
    
  */
} 