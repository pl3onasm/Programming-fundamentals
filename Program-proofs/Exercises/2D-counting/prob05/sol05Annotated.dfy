/* file: sol05Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob05, with annotations
   This is exercise 9.6 from the PC reader
*/

ghost predicate AscAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is ascending 
    // in both its arguments, i.e. 
    // ∀ i,j,k ∈ ℤ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

ghost function F(h:(int,int) -> int, x:nat, y:nat, c:int): int
requires AscAsc(h)
decreases y - x
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(h,x,y,c) = #{ (i,j) | i,j: x ≤ i ≤ j < y ∧ h(i,j) ≤ c }
    // This function counts the number of points in the triangle marked by
    //  { (i,j) | x ≤ i ≤ j < y } that satisfy h(i,j) ≤ c
    // In the initial call F(h,0,n,c), this is the full triangle
    //  { (i,j) | 0 ≤ i ≤ j < n }.
    //
    // Base case: x ≥ y then the triangle is empty and F(h,x,y,c) = # ∅ = 0;
    // Recursive case: in this case we want to shrink the triangle by either 
    //                 incrementing x (which removes the leftmost column) or 
    //                 decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,c)
    //   = #{ (i,j) | i,j: x ≤ i ≤ j < y ∧ h(i,j) ≤ c }
    //        ( split domain into x + 1 ≤ i ≤ j < y and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i ≤ j < y ∧ h(i,j) ≤ c }
    //     + #{ (x,j) | j: x ≤ j < y ∧ h(x,j) ≤ c }
    //       ( apply definition of F to the first term )
    //   = F(h,x+1,y,c) + #{ (x,j) | j: x ≤ j < y ∧ h(x,j) ≤ c }
    //       ( h(x,j) is ascending in j, so the value of h(x,y-1) is maximal;
    //         if we assume h(x,y-1) ≤ c, then h(x,j) ≤ c for all x ≤ j < y and
    //         we can add the whole column to z as it has only matching points )
    //   = F(h,x+1,y,c) + #{ (x,j) | j: x ≤ j < y }
    //       ( size of half-open interval [x,y) is y - x )
    //   = F(h,x+1,y,c) + (y - x)
    //
    // What happens if we decrement y?
    //   F(h,x,y,c)
    //   = #{ (i,j) | i,j: x ≤ i ≤ j < y ∧ h(i,j) ≤ c }
    //        ( split domain into x ≤ i ≤ j < y-1 and j = y-1 )
    //   = #{ (i,j) | i,j: x ≤ i ≤ j < y-1 ∧ h(i,j) ≤ c }
    //     + #{ (i,y-1) | i: x ≤ i ≤ y-1 ∧ h(i,y-1) ≤ c }
    //       ( apply definition of F to the first term )
    //   = F(h,x,y-1,c) + #{ (i,y-1) | i: x ≤ i ≤ y-1 ∧ h(i,y-1) ≤ c }
    //       ( h(i,y-1) is ascending in i, so the value of h(x,y-1) is minimal; 
    //         if we assume h(x,y-1) > c, then h(i,y-1) > c for all x ≤ i ≤ y-1 
    //         and we can discard the whole row as it contains no matching points )
    //   = F(h,x,y-1,c) + # ∅
    //       ( size of the empty set is 0 )
    //   = F(h,x,y-1,c)
  if x >= y then 0
  else if h(x, y - 1) <= c then F(h, x + 1, y, c) + (y - x)
  else F(h, x, y - 1, c)
}

method problem05(h:(int,int) -> int, n:nat, c:int) 
returns (z: int)
requires AscAsc(h)
ensures z == F(h, 0, n, c)
{
    // Initialization to establish J before the loop
    // P: F(h,0,n,c) = Z
    //   ( arithmetic )
    // 0 + F(h,0,n,c) = Z
  var x:nat, y:nat := 0, n;
  z := 0;
    // J: z + F(h,x,y,c) = Z

  while x < y
  invariant z + F(h,x,y,c) == F(h,0,n,c)
  decreases y - x
  {   
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,c) = Z ∧ x < y ∧ (y - x) = V
      //   ( we want to apply the recursive definition of F, so we need
      //     to distinguish the two cases h(x,y-1) ≤ c and h(x,y-1) > c )

    if h(x, y - 1) <= c
    {
        // z + F(h,x,y,c) = Z ∧ h(x,y-1) ≤ c ∧ x < y ∧ (y - x) = V
        //   ( apply the def of F; x < y ensures we are in the recursive case )
        // z + F(h,x+1,y,c) + (y - x) = Z ∧ (y - x) = V
      z := z + (y - x);
        // z + F(h,x+1,y,c) = Z ∧ (y - x) = V
        //   ( prepare for incrementing x )
        // z + F(h,x+1,y,c) = Z ∧ (y - (x + 1)) < V
      x := x + 1;
        // z + F(h,x,y,c) = Z ∧ (y - x) < V
    }
    
    else
    { 
        // z + F(h,x,y,c) = Z ∧ h(x,y-1) > c ∧ x < y ∧ (y - x) = V
        //   ( apply the def of F; x < y ensures we are in the recursive case )
        // z + F(h,x,y-1,c) = Z ∧ (y - x) = V
        //   ( prepare for decrementing y )
        // z + F(h,x,y-1,c) = Z ∧ ((y - 1) - x) < V
      y := y - 1;
        // z + F(h,x,y,c) = Z ∧ (y - x) < V
    }
    
      // Collect branches:
      // z + F(h,x,y,c) = Z ∧ (y - x) < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function vf has decreased )
  }
    
    // J ∧ ¬B
    // z + F(h,x,y,c) = Z ∧ x ≥ y
    //   ( apply the base case of F )
    // z + 0 = Z
    // Q: z = Z
}