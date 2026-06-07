/* file: sol07Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob07, with annotations
   This is exercise 9.8 from the PC reader
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

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, n:nat): int
requires AscAsc(h)
decreases n - x + y
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(h,x,y,n) = #{ (i,j) | i,j: x ≤ i ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    // This function counts the number of points in the rectangle marked by
    //  { (i,j) | x ≤ i < n ∧ 0 ≤ j < y } that lie below the diagonal (i + j < n) 
    //  and satisfy h(i,j) > 0
    // In the initial call F(h,0,n,n), we call this function on the full rectangle
    //  { (i,j) | 0 ≤ i < n ∧ 0 ≤ j < n }
    //
    // Base case: x ≥ n or y = 0 then the rectangle is empty and F(h,x,y,n) = # ∅ = 0
    // Recursive case: in this case we want to shrink the rectangle by either 
    //                 incrementing x (which removes the leftmost column) or 
    //                 decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,n)
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    //        ( split domain into x + 1 ≤ i < n and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i < n ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    //     + #{ (x,j) | j: 0 ≤ j < y ∧ x + j < n ∧ h(x,j) > 0 }
    //        ( apply definition of F to the first term )
    //   = F(h,x+1,y,n) + #{ (x,j) | j: 0 ≤ j < y ∧ j < n - x ∧ h(x,j) > 0 }
    //        ( h(x,j) is ascending in j, so the value of h(x,y-1) is maximal;
    //          if we assume h(x,y-1) ≤ 0, then h(x,j) ≤ h(x,y-1) ≤ 0 for all j < y, 
    //          so we can discard the whole column as it contains no matching points )
    //   = F(h,x+1,y,n) + # ∅
    //        ( size of the empty set is 0 )
    //   = F(h,x+1,y,n)
    //
    // What happens if we decrement y?  
    //   F(h,x,y,n)
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ 0 ≤ j < y ∧ i + j < n ∧ h(i,j) > 0 }
    //        ( split domain into 0 ≤ j < y - 1 and j = y - 1 )
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ 0 ≤ j < y - 1 ∧ i + j < n ∧ h(i,j) > 0 }
    //     + #{ (i,y-1) | i: x ≤ i < n ∧ i + y - 1 < n ∧ h(i,y-1) > 0 }
    //        ( apply definition of F to the first term )
    //   = F(h,x,y-1,n) + #{ (i,y-1) | i: x ≤ i < n ∧ i < n - (y - 1) ∧ h(i,y-1) > 0 }
    //        ( h(i,y-1) is ascending in i, so the value of h(x,y-1) is minimal;
    //          if we assume h(x,y-1) > 0, then h(i,y-1) > 0 for all i ≥ x, 
    //          so all points in the row y - 1 that lie below the diagonal are matching points;
    //          in other words, if x + y ≤ n then the diagonal-clipped row segment contributes
    //          to the count, otherwise the segment is empty and contributes nothing )
    //   = F(h,x,y-1,n) + x ≤ n - (y - 1) ? # { (i,y-1) | i: x ≤ i < n ∧ i < n - (y - 1) } : # ∅
    //        ( size of half-open interval is upper bound - lower bound;
    //          size of the empty set is 0 )
    //   = F(h,x,y-1,n) + x ≤ n - (y - 1) ? n - x - y + 1 : 0

  if x >= n || y == 0 then 0
  else if h(x, y - 1) <= 0 
       then F(h, x + 1, y, n)
       else if x + y <= n 
            then F(h, x, y - 1, n) + n - x - y + 1
            else F(h, x, y - 1, n)
}

method problem07(h:(nat,nat) -> int, n:nat) 
returns (r: int)
requires AscAsc(h)
ensures r == F(h,0,n,n)
{
    // Initialization to establish J before the loop
    // P: F(h,0,n,n) = Z
    //   ( arithmetic )
    // 0 + F(h,0,n,n) = F(h,0,n,n)
  var x, y, z := 0, n, 0;
    // J: z + F(h,x,y,n) = F(h,0,n,n)

  while x < n && y > 0
  invariant z + F(h,x,y,n) == F(h,0,n,n)
  decreases n - x + y
  {   
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,n) = F(h,0,n,n) ∧ x < n ∧ y > 0 ∧ n - x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x,y-1) ≤ 0 and h(x,y-1) > 0 )

    if h(x, y - 1) <= 0 
    {
        // z + F(h,x,y,n) = F(h,0,n,n) ∧ h(x,y-1) ≤ 0 ∧ x < n ∧ y > 0 ∧ n - x + y = V
        //   ( apply definition of F )
        // z + F(h,x+1,y,n) = F(h,0,n,n) ∧ n - x + y = V
        //   ( prepare incrementing x ) 
        // z + F(h,x+1,y,n) = F(h,0,n,n) ∧ n - (x + 1) + y < V
      x := x + 1;
        // z + F(h,x,y,n) = F(h,0,n,n) ∧ n - x + y < V
    }

    else 
    {
      if x + y <= n 
      {
          // z + F(h,x,y,n) = F(h,0,n,n) ∧ h(x,y-1) > 0 ∧ x + y ≤ n ∧ x < n ∧ y > 0 ∧ n - x + y = V
          //   ( apply definition of F )
          // z + F(h,x,y-1,n) + n - x - y + 1 = F(h,0,n,n) ∧ n - x + y = V
        z := z + n - x - y + 1;
          // z + F(h,x,y-1,n) = F(h,0,n,n) ∧ n - x + y = V
      }

      else 
      {
        // z + F(h,x,y,n) = F(h,0,n,n) ∧ h(x,y-1) > 0 ∧ x + y > n ∧ x < n ∧ y > 0 ∧ n - x + y = V
        //   ( apply definition of F )
        // z + F(h,x,y-1,n) = F(h,0,n,n) ∧ n - x + y = V
      }

        // Collect branches:
        // z + F(h,x,y-1,n) = F(h,0,n,n) ∧ n - x + y = V
        //   ( prepare decrementing y )
        // z + F(h,x,y-1,n) = F(h,0,n,n) ∧ n - x + (y - 1) < V
      y := y - 1;
        // z + F(h,x,y,n) = F(h,0,n,n) ∧ n - x + y < V
    }


      // Collect branches: 
      // z + F(h,x,y,n) = F(h,0,n,n) ∧ n - x + y < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function decreases )

  }

    // J ∧ ¬B
    // z + F(h,x,y,n) = F(h,0,n,n) ∧ (x >= n || y == 0)
    //   ( apply base case of F )
    // z + 0 = F(h,0,n,n)
    // z = F(h,0,n,n)
  r := z;
    // r = F(h,0,n,n)
    // Q: r = Z
}