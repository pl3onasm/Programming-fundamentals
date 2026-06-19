/* file: sol11Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob11, with annotations
   This is exercise 9.13 from the PC reader
   NOTE: The loop is machine-verified against the recursive definition of F. 
    The connection between F(p,0,0,m) and the set-based specification from the 
    problem statement is manually derived and justified in the comments, but 
    not machine-verified. This avoids the additional technical machinery that 
    would be needed in Dafny to introduce the corresponding finite sets, 
    reason about their cardinalities, and prove the equivalence of the 
    set-based specification and the recursive definition of F. It also keeps 
    the solution in line with the PC lecture notes.
*/

ghost predicate Incr(arr: array<int>)
reads arr
{
  forall i,j:: 0 <= i < j < arr.Length ==> arr[i] < arr[j]
}               
    
method problem11(a: array<int>, b: array<int>)
returns (r: int)
requires Incr(a) && Incr(b)
ensures r == ???
{
  /* 
    Given is the fact that both arrays a and b are increasingly sorted.
    
    Derive a command sequence T that satisfies the following 
    specification:

      const m,n : ℕ;
      const a   : array [0..m) of ℤ;
      const b   : array [0..n) of ℤ;
      var   z   : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i ∧ 0 ≤ j ∧ i + 2 * j < m ∧ p(i,j) }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
  */
}