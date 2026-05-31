/* file: sol03Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob03, with annotations
   This is exercise 9.4 from the PC reader

   NOTE: here we take the same approach as in prob02, by starting the search
   from the upper-right corner and shrinking the rectangle in a south-western
   direction by either decrementing x or y. 
*/

ghost predicate DecrAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is decreasing in its first 
    // argument and ascending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℤ:
    //   if i < j then f(i,k) > f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <  j  ==>  f(i,k) >  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(h:(int,int) -> int, x:int, y:int, w:int): int
requires DecrAsc(h)
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // F is defined as:
    //   F(h,x,y,w) = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    // This function counts the number of points in the rectangle [0,x) × [0,y) 
    // that satisfy h(i,j) = w. 
    // Base case: x ≤ 0 or y ≤ 0, then the rectangle is empty and F(x,y) = # ∅ = 0.
    // Recursive case: in this case we want to shrink the rectangle by either
    //                 decrementing x or y. 
    //
    // What happens if we decrement x? 
    //   F(x,y)
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    //       ( split domain into 0 ≤ i < x-1 and i = x-1 )
    //   = #{ (i,j) | i,j: 0 ≤ i < x-1 ∧ 0 ≤ j < y ∧ h(i,j) = w }
    //     + #{ (x-1,j) | j: 0 ≤ j < y ∧ h(x-1,j) = w }
    //       ( apply definition of F to the first term )
    //   = F(h, x-1,y,w) + #{ (x-1,j) | j: 0 ≤ j < y ∧ h(x-1,j) = w }
    //       ( h(x-1, j) is ascending in j, so the value of h(x-1,y-1) is maximal,
    //         so if we assume h(x-1,y-1) < w, then h(x-1,j) < w for all 0 ≤ j < y )
    //   = F(h, x - 1,y,w) + # ∅
    //   = F(h, x - 1,y,w)
    //
    // What happens if we decrement y?
    //   F(h,x,y,w)
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    //       ( split domain into 0 ≤ j < y-1 and j = y-1 )
    //   = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y-1 ∧ h(i,j) = w }
    //     + #{ (i,y-1) | i: 0 ≤ i < x ∧ h(i,y-1) = w }
    //       ( apply definition of F to the first term )
    //   = F(h, x, y-1, w) + #{ (i,y-1) | i: 0 ≤ i < x ∧ h(i,y-1) = w }
    //       ( h(i,y-1) is strictly decreasing in i, so the value of h(x-1,y-1) is  
    //         minimal, so if we assume h(x-1,y-1) ≥ w, then either h(x-1,y-1) = w 
    //         for only that point or h(i,y-1) > w for all 0 ≤ i < x )
    //   = F(h, x, y-1, w) + ord(h(x-1,y-1) = w) 

  if x <= 0 || y <= 0 then 0
  else if h(x - 1, y - 1) < w then F(h, x - 1, y, w)
  else F(h, x, y - 1, w) + ord(h(x - 1, y - 1) == w)
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (r: int)
requires DecrAsc(h)
ensures r == F(h, m ,n, w)
{
    // Initialization to establish J before the loop
    // P: F(h,m,n,w) = Z
    //   ( arithmetic )
    // 0 + F(h,m,n,w) = F(h,m,n,w)
  var x, y, z := m, n, 0;
    // J: z + F(h,x,y,w) = F(h,m,n,w)

  while x > 0 && y > 0
  invariant z + F(h, x, y, w) == F(h, m, n, w)
  decreases x + y
  {
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,w) = F(h,m,n,w) ∧ x > 0 ∧ y > 0 ∧ x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x-1,y-1) < w and h(x-1,y-1) ≥ w )

    if h(x - 1, y - 1) < w
    {
        // z + F(h,x,y,w) = F(h,m,n,w) ∧ h(x-1,y-1) < w ∧ x > 0 ∧ y > 0 ∧ x + y = V
        //   ( apply definition of F; 
        //     since x > 0 ∧ y > 0, we are not in the base case )
        // z + F(h,x-1,y,w) = F(h,m,n,w) ∧ x + y = V
        //   ( prepare for decrementing x )
        // z + F(h,x-1,y,w) = F(h,m,n,w) ∧ x - 1 + y < V
      x := x - 1;
        // z + F(h,x,y,w) = F(h,m,n,w) ∧ x + y < V
    }

    else
    {
        // z + F(h,x,y,w) = F(h,m,n,w) ∧ h(x-1,y-1) ≥ w ∧ x > 0 ∧ y > 0 ∧ x + y = V
        //   ( apply definition of F; 
        //     since x > 0 ∧ y > 0, we are not in the base case )
        // z + F(h,x,y-1,w) + ord(h(x-1,y-1) = w) = F(h,m,n,w) ∧ x + y = V
      z := z + ord(h(x - 1, y - 1) == w);
        // z + F(h,x,y-1,w) = F(h,m,n,w) ∧ x + y = V
        //   ( prepare for decrementing y )
        // z + F(h,x,y-1,w) = F(h,m,n,w) ∧ x + (y - 1) < V
      y := y - 1;
        // z + F(h,x,y,w) = F(h,m,n,w) ∧ x + y < V
    }

      // Collect branches:
      // z + F(h,x,y,w) = F(h,m,n,w) ∧ x + y < V
      // J ∧ vf < V
      //   ( J is preserved and vf has decreased )
  }

    // J ∧ ¬B
    // z + F(h,x,y,w) = F(h,m,n,w) ∧ x ≤ 0 ∨ y ≤ 0
    //   ( apply base case of F )
    // z + 0 = F(h,m,n,w)
    // z = F(h,m,n,w)
  r := z;
    // r = F(h,m,n,w)
    // Q: r = Z
}