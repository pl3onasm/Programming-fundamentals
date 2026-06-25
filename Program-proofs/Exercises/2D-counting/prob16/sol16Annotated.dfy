/* file: sol16Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob16, with annotations
   This is exercise 9.18 from the PC reader

   NOTE: The loop is machine-verified against the recursive
   definition of F. The connection between F(f,n,0,n,w)
   and the set-based specification from the problem statement is
   manually derived and justified in the comments, but not
   machine-verified. This avoids the additional technical machinery
   needed for sets and cardinalities in Dafny, and keeps the solution
   in line with the PC lecture notes.
*/

ghost predicate AscAsc(f:(nat,nat) -> int) 
{
    // Expresses the property that f is ascending in 
    // both its arguments, i.e.
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}                

ghost function F(f:(nat,nat) -> int, x:nat, y:nat,
                 n:nat, w:int): int
requires AscAsc(f)
requires x <= n
requires y <= n
decreases x + (n - y)
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(f,x,y,n,w) = #{ (i,j) | i,j: y ≤ j ∧ 2j ≤ i < x ∧ f(i,j) < w }
    // That is, F(f,x,y,n,w) counts the number of points (i,j) that lie in the
    // triangle marked by the line 2j = i, the vertical line i = x and the 
    // horizontal line j = y, and for which f(i,j) < w. 
    // When this function is initially called as F(f,n,0,n,w), the remaining
    // search area is the full triangular domain { (i,j) | 0 ≤ j ∧ 2j ≤ i < n },
    // which is exactly the domain from the problem statement.
    //
    // Base case: if x = 0 or y = n or 2y ≥ x, then the remaining search area 
    //            is empty, so F(f,x,y,n,w) = #∅ = 0.
    //
    // Recursive case: here we want to shrink the remaining triangular area by 
    //   - either decrementing x (which removes the rightmost column)
    //   - or incrementing y (which removes the bottommost row)
    //
    // What happens if we decrement x?
    //   F(f,x,y,n,w) 
    //   = #{ (i,j) | i,j: y ≤ j ∧ 2j ≤ i < x ∧ f(i,j) < w }
    //     ( split the domain into two disjoint subsets, one for the rightmost
    //       column i = x-1 and one for the remaining area 2j ≤ i < x-1 )
    //   = #{ (i,j) | i,j: y ≤ j ∧ 2j ≤ i < x-1 ∧ f(i,j) < w }
    //     + #{ (x-1,j) | j: y ≤ j ∧ 2j ≤ x-1 ∧ f(x-1,j) < w }
    //     ( apply the definition of F to the first term )
    //   = F(f,x-1,y,n,w) + #{ (x-1,j) | j: y ≤ j ∧ 2j ≤ x-1 ∧ f(x-1,j) < w }
    //     ( f is ascending in j, so f(x-1,y) is minimal in the rightmost column;
    //       if we assume that f(x-1,y) ≥ w, then f(x-1,j) ≥ w for all j ≥ y, 
    //       and the entire rightmost column can be discarded )
    //   = F(f,x-1,y,n,w) + #∅
    //   = F(f,x-1,y,n,w)
    //
    // What happens if we increment y?
    //   F(f,x,y,n,w)        
    //   = #{ (i,j) | i,j: y ≤ j ∧ 2j ≤ i < x ∧ f(i,j) < w }
    //     ( split the domain into two disjoint subsets, one for the bottommost
    //       row j = y and one for the remaining area y+1 ≤ j < n )
    //   = #{ (i,j) | i,j: y+1 ≤ j ∧ 2j ≤ i < x ∧ f(i,j) < w }
    //     + #{ (i,y) | i: 2y ≤ i < x ∧ f(i,y) < w }
    //     ( apply the definition of F to the first term )
    //   = F(f,x,y+1,n,w) + #{ (i,y) | i: 2y ≤ i < x ∧ f(i,y) < w }
    //     ( f is ascending in i, so f(x-1,y) is maximal in the current bottom 
    //       row segment 2y ≤ i < x. Hence, if we assume that f(x-1,y) < w, 
    //       then f(i,y) < w for all i with 2y ≤ i < x, and the entire 
    //       bottommost row can be added to the count )
    //   = F(f,x,y+1,n,w) + #{ (i,y) | i: 2y ≤ i < x }
    //     ( size of half-open interval [2y,x) is x - 2y )
    //   = F(f,x,y+1,n,w) + x - 2y

  if x == 0 || y == n || 2 * y >= x 
  then 0 
  else if f(x-1,y) >= w 
       then F(f,x-1,y,n,w) 
       else F(f,x,y+1,n,w) + x - 2 * y
}

method problem16(f:(nat,nat) -> int, n:nat, w:int)
returns (z: int)
requires AscAsc(f)
ensures z == F(f, n, 0, n, w)
{
    // Initialization to establish J before the loop
    // P: F(f,n,0,n,w) = Z
    //   ( arithmetic )
    // 0 + F(f,n,0,n,w) = Z
  var x:nat, y:nat := n, 0;
  z := 0;
    // J: z + F(f,x,y,n,w) = Z

  while x > 0 && y < n && 2 * y < x
  invariant 0 <= x <= n && 0 <= y <= n
  invariant z + F(f,x,y,n,w) == F(f,n,0,n,w)
  decreases x + (n - y)
  {
      // J ∧ B ∧ vf = V
      // z + F(f,x,y,n,w) = Z ∧ x > 0 ∧ y < n ∧ 2y < x ∧ x + (n - y) = V
      //   ( we want to apply the recursive definition of F, so we need
      //     to distinguish the two cases f(x-1,y) ≥ w and f(x-1,y) < w )

    if f(x-1,y) >= w
    {
        // z + F(f,x,y,n,w) = Z ∧ f(x-1,y) ≥ w ∧ x > 0 ∧ y < n ∧ 2y < x ∧ x + (n - y) = V
        //   ( apply recursive definition of F )
        // z + F(f,x-1,y,n,w) = Z ∧ x + (n - y) = V
        //   ( prepare for decrementing x )
        // z + F(f,x-1,y,n,w) = Z ∧ (x - 1) + (n - y) < V
      x := x - 1;
        // z + F(f,x,y,n,w) = Z ∧ x + (n - y) < V
    }

    else 
    {
        // z + F(f,x,y,n,w) = Z ∧ f(x-1,y) < w ∧ x > 0 ∧ y < n ∧ 2y < x ∧ x + (n - y) = V
        //   ( apply recursive definition of F )
        // z + F(f,x,y+1,n,w) + x - 2y = Z ∧ x + (n - y) = V
      z := z + x - 2 * y;
        // z + F(f,x,y+1,n,w) = Z ∧ x + (n - y) = V
        //   ( prepare for incrementing y )
        // z + F(f,x,y+1,n,w) = Z ∧ x + (n - (y + 1)) < V
      y := y + 1;
        // z + F(f,x,y,n,w) = Z ∧ x + (n - y) < V
    }

      // Collect branches:
      // z + F(f,x,y,n,w) = Z ∧ x + (n - y) < V
      // J ∧ vf < V 
      //   ( the loop invariant is preserved and the variant decreases )
  }
    
    // J ∧ ¬B
    // z + F(f,x,y,n,w) = Z ∧ (x = 0 ∨ y = n ∨ 2y ≥ x)
    //   ( apply base case of F )
    // z + 0 = Z 
    // Q: z = Z
} 