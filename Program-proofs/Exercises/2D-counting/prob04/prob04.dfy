/* file: prob04.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob04
   This is exercise 9.5 from the PC reader
*/

ghost predicate IncrIncr(f:(int,int) -> int) 
{
    // Expresses the property that f is strictly increasing 
    // in both its arguments, i.e. 
    // ∀ i,j,k ∈ ℤ:
    //   if i < j then f(i,k) < f(j,k)
    //   if j < k then f(i,j) < f(i,k)
  (forall i,j,k:: i < j  ==>  f(i,k) < f(j,k)) &&
  (forall i,j,k:: j < k  ==>  f(i,j) < f(i,k))
}

method problem04(g:(int,int) -> int, m:nat, n:nat) 
returns (r: int)
requires IncrIncr(g)
ensures r == ???
{
  /* 
    Given is a function g: ℤ × ℤ → ℤ that is strictly increasing in 
    both arguments. 
    Derive a command sequence T that satisfies the following 
    specification:
  
      const m,n: ℕ
      var   r: ℤ

        {P: Z = #{ (i,j) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ g(i,j) = j } }
      T
        {Q: r = Z}
     
    The time complexity of T should be in O(m + n).
  */
}