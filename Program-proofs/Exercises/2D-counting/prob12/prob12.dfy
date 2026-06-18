/* file: prob12.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob12
   This is exercise 9.14 from the PC reader
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
    
method problem12(h:(int,int) -> int, m:nat, n:nat)
returns (r: int)
requires AscAsc(h)
requires 0 < m && 0 < n
ensures r == ???
{
  /* 
    Given is a function h: ℤ × ℤ → ℤ that is ascending in both arguments.
    
    Derive a command sequence T that satisfies the following 
    specification:

      const m,n : ℕ₊;
      var   z   : ℤ;
      
        {P : Z = Min{ |h(i,j)| | i,j: 0 ≤ i < m ∧ 0 ≤ j < n }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program 
    variable, whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}