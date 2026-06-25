/* file: prob06.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob06
   This is exercise 9.7 from the PC reader
*/

ghost predicate IncrDesc(f:(nat,nat) -> int) 
{
    // Expresses the property that f is increasing in its first  
    // argument and descending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℕ:
    //   if i < j then f(i,k) < f(j,k)
    //   if j ≤ k then f(i,j) ≥ f(i,k)
  (forall i,j,k:: i <  j  ==>  f(i,k) <  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}

method problem06(g:(nat,nat) -> int, n:nat, w:int) 
returns (z: int)
requires IncrDesc(g)
ensures z == ???
{
  /* 
    Given is a function g: ℕ × ℕ → ℤ that is ascending in 
    its first argument and descending in its second argument.

    Derive a command sequence T that satisfies the following 
    specification:

      const n : ℕ;
      const w : ℤ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i < n ∧ 0 ≤ j < n ∧ i + j < n ∧ g(i,j) = w } }
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable. 
    The time complexity of T should be in O(n).
  */
}