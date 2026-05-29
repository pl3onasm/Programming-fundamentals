/* file: sol03Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob03, with annotations
   This is exercise 9.4 from the PC reader

   NOTE: here we take an alternative approach to the solution of prob03, 
   by starting the search from the lower-left corner and shrinking the
   rectangle in a north-eastern direction by either incrementing x or y.
   This is just to show that there are multiple ways to solve the problem, 
   and that the chosen approach affects the definitions and the proof. 
   For example, for this alternative approach to work, we need to change 
   the definition of F to include the bounds m and n, as well as the 
   post condition of the method to reflect the new definition of F. 
   Initialization is also different, since F has a different base case.
*/

ghost predicate DecrAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is decreasing in its first 
    // argument and ascending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℕ:
    //   if i < j then f(i,k) > f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <  j  ==>  f(i,k) >  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(h:(int,int) -> int, x:int, y:int, m:int, n:int, w:int): int
requires DecrAsc(h)
decreases (m - x) + (n - y)
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // F is defined as:
    //   F(h,x,y,m,n,w) = #{ (i,j) | i,j: x ≤ i < m ∧ y ≤ j < n ∧ h(i,j) = w }
    // This function counts the number of points in the rectangle [x,m) × [y,n)
    // that satisfy h(i,j) = w. 
    // Base case: x ≥ m or y ≥ n, then the rectangle is empty 
    //            and F(h,x,y,m,n,w) = # ∅ = 0.
    // Recursive case: in this case we want to shrink the rectangle by either
    //                 incrementing x or y. 
    //
    // What happens if we increment x? 
    // F(x,y)
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ y ≤ j < n ∧ h(i,j) = w }
    //      ( split domain into x + 1 ≤ i < m and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i < m ∧ y ≤ j < n ∧ h(i,j) = w }
    //     + #{ (x,j) | j: y ≤ j < n ∧ h(x,j) = w }
    //      ( apply definition of F to the first term )
    //   = F(h, x + 1,y,m,n,w) + #{ (x,j) | j: y ≤ j < n ∧ h(x,j) = w }
    //      ( h(x, j) is ascending in j, so the value of h(x,y) is minimal,
    //        so if h(x,y) > w, then h(x,j) > w for all y ≤ j < n )
    //   = F(h, x + 1,y,m,n,w) + # ∅ 
    //   = F(h, x + 1,y,m,n,w) 
    //
    // What happens if we increment y?
    // F(x,y)
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ y ≤ j < n ∧ h(i,j) = w }
    //      ( split domain into y + 1 ≤ j < n and j = y )
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ y + 1 ≤ j < n ∧ h(i,j) = w }
    //     + #{ (i,y) | i: x ≤ i < m ∧ h(i,y) = w }
    //      ( apply definition of F to the first term )
    //   = F(h, x, y + 1,m,n,w) + #{ (i,y) | i: x ≤ i < m ∧ h(i,y) = w }
    //      ( h(i,y) is strictly decreasing in i, so the value of h(x,y) is maximal, 
    //        so if we assume h(x,y) ≤ w, then either h(x,y) = w 
    //        or h(i,y) < w for all x ≤ i < m )
    //   = F(h, x, y + 1,m,n,w) + ord(h(x,y) = w)

  if x >= m || y >= n then 0
  else if h(x, y) > w then F(h, x + 1, y, m, n, w)
  else F(h, x, y + 1, m, n, w) + ord(h(x, y) == w)
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (r: int)
requires DecrAsc(h)
ensures r == F(h, 0, 0, m, n, w)
{
  var x, y, z := 0, 0, 0;
  
  while x < m && y < n
  invariant z + F(h, x, y, m, n, w) == F(h, 0, 0, m, n, w)
  decreases (m - x) + (n - y)
  {
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ x < m ∧ y < n ∧ (m - x) + (n - y) = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x,y) > w and h(x,y) ≤ w )

    if h(x, y) > w
    {
        // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ h(x,y) > w ∧ x < m ∧ y < n ∧ (m - x) + (n - y) = V
        //   ( apply definition of F; since x < m ∧ y < n, we are not in the base case )
        // z + F(h,x+1,y,m,n,w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - y) = V
        //   ( prepare for incrementing x )
        // z + F(h,x+1,y,m,n,w) = F(h,0,0,m,n,w) ∧ (m - (x + 1)) + (n - y) < V
      x := x + 1;
        // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - y) < V
    }

    else
    {
        // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ h(x,y) ≤ w ∧ x < m ∧ y < n ∧ (m - x) + (n - y) = V
        //   ( apply definition of F; since x < m ∧ y < n, we are not in the base case )
        // z + F(h,x,y+1,m,n,w) + ord(h(x,y) = w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - y) = V
      z := z + ord(h(x, y) == w);
        // z + F(h,x,y+1,m,n,w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - y) = V
        //   ( prepare for incrementing y )
        // z + F(h,x,y+1,m,n,w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - (y + 1)) < V
      y := y + 1;
        // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - y) < V
    }

      // Collect branches:
      // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ (m - x) + (n - y) < V
      // J ∧ vf < V
  }

    // J ∧ ¬B
    // z + F(h,x,y,m,n,w) = F(h,0,0,m,n,w) ∧ x ≥ m ∨ y ≥ n
    //   ( apply base case of F )
    // z + 0 = F(h,0,0,m,n,w)
    // z = F(h,0,0,m,n,w)
  r := z;    
    // Q: r = F(h,0,0,m,n,w)
}