/* file: prob20.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob20  
   This is exercise 9.22 from the PC reader
*/

ghost predicate ConvexFirst(p:(int,int) -> bool)
{
    // Expresses that p is convex in its first argument, i.e.
    // for every fixed second argument w, if p holds at two
    // horizontal endpoints x and z, then it also holds at every
    // point y between them.
    //
    // ∀ x,y,z,w ∈ ℤ:
    //   p(x,w) ∧ x ≤ y ≤ z ∧ p(z,w)  ==>  p(y,w)
  forall x,y,z,w:int :: p(x,w) && x <= y && y <= z && p(z,w) ==> p(y,w)
}

ghost predicate MonoSecond(p:(int,int) -> bool)
{
    // Expresses that p is monotonic in its second argument, i.e.
    // once p holds at height y, it also holds at every larger
    // height z.
    //
    // ∀ x,y,z ∈ ℤ:
    //   p(x,y) ∧ y ≤ z  ==>  p(x,z)
  forall x,y,z:int :: p(x,y) && y <= z ==> p(x,z)
}              
    
method problem20(p:(int,int) -> bool, m:nat, n:nat)
returns (z:int)
requires ConvexFirst(p)
requires MonoSecond(p)
ensures z == ???
{
  /* 
    Given is a predicate p: ℤ × ℤ → 𝔹 for which we know that it is convex 
    in its first argument and monotonic in its second argument.  
    
    Derive a command sequence T that satisfies the following 
    specification:
      
      const m, n : ℕ;
      var   z    : ℤ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i < m ∧ 0 ≤ j < n ∧ p(i,j) }}
      T
        {Q : Z = z}
      
    Note that Z (uppercase) is a specification constant, not a program variable, 
    whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(m + n).
    
  */
} 