/* file: sol14Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob14, with annotations
   This is exercise 9.16 from the PC reader
   NOTE: The loop is machine-verified against the recursive definition of F. 
    The connection between F(p,0,0,m) and the set-based specification from the 
    problem statement is manually derived and justified in the comments, but 
    not machine-verified. This avoids the additional technical machinery that 
    would be needed in Dafny to introduce the corresponding finite sets, 
    reason about their cardinalities, and prove the equivalence of the 
    set-based specification and the recursive definition of F. It also keeps 
    the solution in line with the PC lecture notes.
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

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, z:int, m:nat): int
requires DescDesc(h)
    
method problem14(h:(nat,nat) -> int, m:nat, n:nat)
returns (r: int)
requires DescDesc(h)
requires h(m,0) <= 0
requires h(0,n) <= 0
ensures r == F(h,0,n,1,m)
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
  */
}