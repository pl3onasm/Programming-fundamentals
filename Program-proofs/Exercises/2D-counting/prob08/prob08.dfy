/* file: prob08.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob08
   This is exercise 9.9 from the PC reader
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

method problem08(h:(int,int) -> int, m:nat, n:nat) 
returns (z: int)
requires AscAsc(h)
ensures z == ???
{
  /* 
    Given is a function h: ℤ × ℤ → ℤ that is ascending in 
    both its arguments.

    Derive a command sequence T that satisfies the following 
    specification:

      const m, n : ℕ;
      var   z    : ℤ;
      
        {P : Z = #{ i | i: 0 ≤ i < m ∧ (∃j: 0 ≤ j < n ∧ h(i,j) = 0) }}
      T
        {Q : Z = z}

    In order to derive T, you should work with the following function F:
     F(h,x,y,n) = #{ i | i: 0 ≤ i < x ∧ (∃j: y ≤ j < n ∧ h(i,j) = 0) }

    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}