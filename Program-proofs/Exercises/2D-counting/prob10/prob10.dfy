/* file: prob10.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob10
   This is exercise 9.12 from the PC reader
*/

ghost predicate prop(p:(int,int) -> bool)
{
    // Expresses the monotonicity rules for p, as given in the problem statement.
    // It states that truth of p propagates eastward and southward, and
    // that falsehood of p propagates westward and northward.
  (forall i,j:: p(i,j)   ==> p(i+1,j)) &&
  (forall i,j:: p(i,j+1) ==> p(i,j))
}               
    
method problem10(p:(int,int) -> bool, m:nat)
returns (z: int)
requires prop(p)
ensures z == ???
{
  /* 
    Given is a predicate p: ℤ × ℤ → B, which satisfies the following monotonicity rules:

      p(i,j)   ⇒ p(i+1,j)
      p(i,j+1) ⇒ p(i,j)
    
    Derive a command sequence T that satisfies the following 
    specification:

      const m : ℕ;
      var   z : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i ∧ 0 ≤ j ∧ i + 2 * j < m ∧ p(i,j) }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m).
  */
}