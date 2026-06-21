/* file: sol15Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob15, with annotations
   This is exercise 9.17 from the PC reader
   NOTE: The loop is machine-verified against the recursive definition of F. 
    The connection between F(h,0,n,0,m) and the set-based specification from the 
    problem statement is manually derived and justified in the comments, but 
    not machine-verified. This avoids the additional technical machinery that 
    would be needed in Dafny to introduce the corresponding finite sets, 
    reason about their maxima, and prove the equivalence of the set-based 
    specification and the recursive definition of F. It also keeps the solution 
    in line with the PC lecture notes.
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

function mxm(x:int, y:int): int
{
  if x >= y then x else y
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, z:int, m:nat): int
requires DescDesc(h)
requires 0 <= x <= m
requires 0 <= y
decreases m - x + y
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(h,x,y,z,m) = Max{ {z} ∪ { (i+1)⋅(j+1) | x ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > 0} }
    //
    // In other words, F(h,x,y,z,m) is the best value already found, namely z, maximized 
    // with the values of (i+1)⋅(j+1) in the remaining rectangle for which h(i,j) > 0. 
    // When this function is initially called as F(h,0,n,0,m), the remaining rectangle 
    // is the full search area { (i,j) | 0 ≤ i < m ∧ 0 ≤ j < n }, and the best value 
    // found so far is initialized to 0. Since every candidate product (i+1)⋅(j+1) is 
    // positive, the value 0 represents the case where no positive h(i,j) values have
    // been found yet. Thus, for this specification, the maximum of an empty set of 
    // candidate products is represented by 0.
    // 
    // Base case: if x ≥ m or y = 0, then the remaining search area is empty, so 
    //            F(h,x,y,z,m) = Max{ {z} ∪ ∅ } = z.
    //
    // Recursive case: here we want to shrink the remaining search area by 
    //   - either incrementing x (which removes the leftmost column)
    //   - or decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,z,m)
    //   = Max{ {z} ∪ { (i+1)⋅(j+1) | x ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > 0} }
    //        ( split domain into x + 1 ≤ i < m and i = x )
    //   = Max{ {z} ∪ { (i+1)⋅(j+1) | x + 1 ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > 0}
    //              ∪ { (x+1)⋅(j+1) | j: 0 ≤ j < y ∧ h(x,j) > 0} }
    //        ( h(x,j) is descending in j, so the value of h(x,y-1) is minimal; 
    //          if we assume h(x,y-1) > 0, then h(x,j) > 0 for all j < y. 
    //          The maximal product value is attained at the topmost point 
    //          (x,y-1), which has value (x+1)⋅y. We can update z to this value and
    //          discard the rest of the column, as it contains no larger product values )
    //   = Max{ {mxm(z, (x+1)⋅y)} ∪ { (i+1)⋅(j+1) | x + 1 ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > 0} }
    //        ( apply definition of F )
    //   = F(h,x+1,y,mxm(z, (x+1)⋅y),m)
    //        
    // What happens if we decrement y?
    //   F(h,x,y,z,m)
    //   = Max{ {z} ∪ { (i+1)⋅(j+1) | x ≤ i < m ∧ 0 ≤ j < y ∧ h(i,j) > 0} }
    //        ( split domain into 0 ≤ j < y - 1 and j = y - 1 )
    //   = Max{ {z} ∪ { (i+1)⋅(j+1) | x ≤ i < m ∧ 0 ≤ j < y - 1 ∧ h(i,j) > 0}
    //              ∪ { (i+1)⋅y | i: x ≤ i < m ∧ h(i,y-1) > 0} }
    //        ( h(i,y-1) is descending in i, so the value of h(x,y-1) is maximal; 
    //          if we assume h(x,y-1) ≤ 0, then h(i,y-1) ≤ 0 for all i ≥ x, 
    //          so we can discard the whole row y-1, as it contains no matching points )
    //   = Max{ {z} ∪ { (i+1)⋅(j+1) | x ≤ i < m ∧ 0 ≤ j < y - 1 ∧ h(i,j) > 0} } 
    //        ( apply definition of F )
    //   = F(h,x,y-1,z,m)

  if x >= m || y == 0 
  then z
  else if h(x, y - 1) > 0 
       then F(h, x + 1, y, mxm(z, (x + 1) * y), m)
       else F(h, x, y - 1, z, m)
}
    
method problem15(h:(nat,nat) -> int, m:nat, n:nat)
returns (r: int)
requires DescDesc(h)
ensures r == F(h,0,n,0,m)
{
    // Initialization to establish J before the loop
    // P: F(h,0,n,0,m) = Z
  var x:nat, y:nat, z:int := 0, n, 0;
    // J: F(h,x,y,z,m) = Z

  while x < m && y > 0
  invariant 0 <= x <= m && 0 <= y <= n
  invariant F(h,x,y,z,m) == F(h,0,n,0,m)
  decreases (m - x) + y
  {
      // J ∧ B ∧ vf = V
      // F(h,x,y,z,m) = Z ∧ x < m ∧ y > 0 ∧ (m - x) + y = V
      //   ( we want to apply the recursive definition of F, so we need
      //     to distinguish the two cases h(x,y-1) > 0 and h(x,y-1) ≤ 0 )

    if h(x, y - 1) > 0
    {
        // F(h,x,y,z,m) = Z ∧ h(x,y-1) > 0 ∧ x < m ∧ y > 0 ∧ (m - x) + y = V
        //   ( apply definition of F )
        // F(h,x+1,y,mxm(z,(x+1)*y),m) = Z ∧ (m - x) + y = V
      z := mxm(z, (x + 1) * y);
        // F(h,x+1,y,z,m) = Z ∧ (m - x) + y = V
        //   ( prepare for incrementing x )
        // F(h,x+1,y,z,m) = Z ∧ (m - (x + 1)) + y < V
      x := x + 1;
        // F(h,x,y,z,m) = Z ∧ (m - x) + y < V
    }

    else
    {
        // F(h,x,y,z,m) = Z ∧ h(x,y-1) ≤ 0 ∧ x < m ∧ y > 0 ∧ (m - x) + y = V
        //   ( apply definition of F )
        // F(h,x,y-1,z,m) = Z ∧ (m - x) + y = V
        //   ( prepare for decrementing y )
        // F(h,x,y-1,z,m) = Z ∧ (m - x) + (y - 1) < V
      y := y - 1;
        // F(h,x,y,z,m) = Z ∧ (m - x) + y < V
    }

    // Collect branches:
    // F(h,x,y,z,m) = Z ∧ (m - x) + y < V
    // J ∧ vf < V
    //   ( J is preserved and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // F(h,x,y,z,m) = Z ∧ (x ≥ m ∨ y ≤ 0)
    //   ( apply the base case of F )
    // z = Z
  r := z;
    // Q: r = Z
}