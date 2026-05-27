/* file: prob01.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob01
   This is exercise 9.2 from the PC reader
*/

ghost predicate AscDesc(f:(nat,nat) -> int) {
    // Expresses the property that f is ascending in its first 
    // argument and descending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≥ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}

method search2D(h:(nat,nat) -> int, c: int, ghost X: nat, ghost Y: nat) 
returns (x: nat, y: nat)
requires AscDesc(h) && h(X,Y) == c
ensures h(x,y) == c
{
  /* 
    Given is a function h: ℕ × ℕ → ℤ that is ascending in its 
    first argument and descending in its second argument, and 
    a value c ∈ ℤ such that h(X,Y) = c for some X,Y ∈ ℕ.
    The goal is to find a point (x,y) such that h(x,y) = c.
    It is given that at least one such point exists.
    In other words, derive a command sequence T that satifies 
    the following specification:
  
      const c: ℤ
      var x,y: ℤ
        {P: 0 ≤ X ∧ 0 ≤ Y ∧ h(X,Y) = c}
      T
        {Q: 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ h(x,y) = c}
     
    Use the shrinking rectangle method to derive T. A suitable
    invariant can be found by isolating a conjunct from Q.
    The time complexity of T should be in O(X + Y).
  */
}