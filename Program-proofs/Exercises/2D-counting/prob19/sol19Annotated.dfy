/* file: sol19Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob19, with annotations
   This is exercise 9.21 from the PC reader

   NOTE: The loop is machine-verified against the recursive
   definition of F. The connection between F(h,n,0,n,c)
   and the set-based specification from the problem statement is
   manually derived and justified in the comments, but not
   machine-verified. This avoids the additional technical machinery
   needed for sets and cardinalities in Dafny, and keeps the solution
   in line with the PC lecture notes.
*/

ghost predicate AscIncr(h:(nat,nat) -> int) 
{
    // Expresses the property that h is ascending in its first
    // argument and strictly increasing in its second argument, i.e.
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then h(i,k) ≤ h(j,k)
    //   if j < k then h(i,j) < h(i,k)
  (forall i,j,k :: i <= j ==> h(i,k) <= h(j,k)) &&
  (forall i,j,k :: j <  k ==> h(i,j) <  h(i,k))
}

function Ord(b:bool): nat
{
  if b then 1 else 0
}

ghost function Gap(h:(nat,nat) -> int, x:nat, y:nat, c:int): nat
{
    // This function measures how far the current point (x-1,y)
    // still lies below the target value c. If x = 0, or if the
    // current point is already at least c, then the gap is 0.
    // Otherwise, the gap is the difference between c and the value
    // of h at the current point.
  if 0 < x && h(x-1,y) < c then c - h(x-1,y) else 0
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat, c:int): nat
requires AscIncr(h)
requires x <= n
decreases x, Gap(h,x,y,c)
{
    // We want to find a recursive definition of F that we can use to
    // derive T. We define F as follows:
    //   F(h,x,y,n,c) = #{ (i,j) | 0 ≤ i < x ∧ y ≤ j ∧ h(i,j) = c }
    //
    // That is, F(h,x,y,n,c) counts the number of points satisfying 
    // h(i,j) = c in the current semi-infinite strip with horizontal range 
    // [0,x) and vertical range [y,∞). When this function is initially called 
    // as F(h,n,0,n,c), it counts the number of points in the full rectangle
    // marked by:  0 ≤ i < n   and   0 ≤ j

    // Base case: if x = 0, then the rectangle is empty and there are no 
    // points to count.
    //
    // Recursive case: in this case, we want to reduce the search space by
    //   - incrementing y (moving north)
    //   - decrementing x (moving west)

    // What happens if we decrement x? 
    //   F(h,x,y,n,c) 
    //   = #{ (i,j) | 0 ≤ i < x ∧ y ≤ j ∧ h(i,j) = c }
    //      ( split the set into two disjoint subsets: i = x-1 and i < x-1 )
    //   = #{ (i,j) | 0 ≤ i < x-1 ∧ y ≤ j ∧ h(i,j) = c } 
    //      + #{ (x-1,j) | y ≤ j ∧ h(x-1,j) = c }
    //      ( apply definition of F to the first subset )
    //   = F(h,x-1,y,n,c) + #{ (x-1,j) | y ≤ j ∧ h(x-1,j) = c }
    //      ( h is increasing in its second argument, so (x-1,y) is minimal 
    //        in its column. If we assume h(x-1,y) ≥ c,then the only possible 
    //        matching point in this column is (x-1,y) itself.
    //        So we count it if it matches, and otherwise we discard the 
    //        entire column, as h(x-1,j) > c for all j > y. )
    //   = F(h,x-1,y,n,c) + Ord(h(x-1,y) == c)

    // What happens if we increment y?
    //   F(h,x,y,n,c)
    //   = #{ (i,j) | 0 ≤ i < x ∧ y ≤ j ∧ h(i,j) = c }
    //      ( split the set into two disjoint subsets: j = y and j > y )
    //   = #{ (i,y) | 0 ≤ i < x ∧ h(i,y) = c } 
    //      + #{ (i,j) | 0 ≤ i < x ∧ y < j ∧ h(i,j) = c }
    //      ( rewrite the second subset to match the definition of F )
    //   = #{ (i,y) | 0 ≤ i < x ∧ h(i,y) = c } 
    //      + #{ (i,j) | 0 ≤ i < x ∧ y+1 ≤ j ∧ h(i,j) = c }
    //   = #{ (i,y) | 0 ≤ i < x ∧ h(i,y) = c } + F(h,x,y+1,n,c)
    //      ( h is ascending in its first argument, so (x-1,y) is maximal 
    //        in its row. If we assume h(x-1,y) < c, then there can be no 
    //        matching point in this row, as h(i,y) ≤ h(x-1,y) < c for all i < x. 
    //        Hence we can discard the entire row and move north. )
    //   = F(h,x,y+1,n,c)

  if x == 0 then
    0
  else if h(x-1,y) < c then
    F(h,x,y+1,n,c)
  else 
    Ord(h(x-1,y) == c) + F(h,x-1,y,n,c)
}

method problem19(h:(nat,nat) -> int, n:nat, c:int)
returns (z:int)
requires AscIncr(h)
requires c < h(n,0)
ensures z == F(h,n,0,n,c)
{
    // Initialization to establish J before the loop.
    // P: F(h,n,0,n,c) = Z
    //    ( arithmetic )
    // 0 + F(h,n,0,n,c) = Z
  var x:nat := n;
  var y:nat := 0;
  z := 0;
    // J: z + F(h,x,y,n,c) = Z

  while x > 0
    invariant x <= n
    invariant z + F(h,x,y,n,c) == F(h,n,0,n,c)
    decreases x, Gap(h,x,y,c)
  /*
    We choose as variant function: vf = (x, Gap(h,x,y,c))
    The pair is ordered lexicographically. Thus it decreases as x
    decreases, or if x remains unchanged, as Gap(h,x,y,c) decreases.
    This matches the two possible moves of the search:
      - moving north keeps x fixed but decreases the gap to c;
      - moving west decreases x directly.
  */
  {
      // J ∧ B ∧ vf = (X, G)
      // z + F(h,x,y,n,c) = Z ∧ x > 0 ∧ (x, Gap(h,x,y,c)) = (X, G)
      //   ( we want to apply the recursive definition of F to the current
      //     rectangle, so we distinguish the two cases based on the value of 
      //     h(x-1,y) relative to c )

    if h(x-1,y) < c 
    {
        // z + F(h,x,y,n,c) = Z ∧ x > 0 ∧ h(x-1,y) < c 
        //   ∧ (x, Gap(h,x,y,c)) = (X, G)
        //   ( apply definition of F )
        // z + F(h,x,y+1,n,c) = Z ∧ (x, Gap(h,x,y,c)) = (X, G)
        //   ( prepare for incrementing y; because h is strictly increasing in
        //     its second argument, h(x-1,y) < h(x-1,y+1). Since h(x-1,y) < c, 
        //     the old gap is positive, while the new gap is either smaller or 0. )
        // z + F(h,x,y+1,n,c) = Z ∧ (x, Gap(h,x,y+1,c)) < (X, G)
      y := y + 1;
        // z + F(h,x,y,n,c) = Z ∧ (x, Gap(h,x,y,c)) < (X, G)
    } 
    
    else 
    {
        // z + F(h,x,y,n,c) = Z ∧ x > 0 ∧ h(x-1,y) ≥ c
        //   ∧ (x, Gap(h,x,y,c)) = (X, G)
        //   ( apply definition of F )
        // z + Ord(h(x-1,y) == c) + F(h,x-1,y,n,c) = Z ∧ (x, Gap(h,x,y,c)) = (X, G)
      z := z + Ord(h(x-1,y) == c);
        // z + F(h,x-1,y,n,c) = Z ∧ (x, Gap(h,x,y,c)) = (X, G)
        //   ( prepare for decrementing x )
        // z + F(h,x-1,y,n,c) = Z ∧ (x-1, Gap(h,x-1,y,c)) < (X, G)
      x := x - 1;
        // z + F(h,x,y,n,c) = Z ∧ (x, Gap(h,x,y,c)) < (X, G)
    }

      // Collect branches:
      // z + F(h,x,y,n,c) = Z ∧ (x, Gap(h,x,y,c)) < (X, G)
      // J ∧ vf < (X, G)
      //   ( J is preserved, and the variant function decreases )
  }

    // J ∧ ¬B
    // z + F(h,x,y,n,c) = Z ∧ x = 0
    //   ( apply base case of F )
    // z + 0 = Z 
    // Q: z = Z
}