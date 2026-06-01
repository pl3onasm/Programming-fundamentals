/* file: prob05.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob05
   This is exercise 9.6 from the PC reader
*/

ghost predicate AscAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is ascending 
    // in both its arguments, i.e. 
    // ∀ i,j,k ∈ ℤ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

method problem05(h:(int,int) -> int, n:nat, c:int) 
returns (r: int)
requires AscAsc(h)
ensures r == ???
{
  /* 
    Given is a function h: ℤ × ℤ → ℤ that is ascending in 
    both arguments. 
    Derive a command sequence T that satisfies the following 
    specification:

      const n : ℕ;
      const c : ℤ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i ≤ j < n ∧ h(i,j) ≤ c } }
      T
        {Q : Z = z}
      
    The time complexity of T should be in O(n).
  */
}