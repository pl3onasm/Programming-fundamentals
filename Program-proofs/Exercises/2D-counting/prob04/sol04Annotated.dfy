/* file: sol04Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob04, with annotations
   This is exercise 9.5 from the PC reader
*/

ghost predicate IncrIncr(f:(int,int) -> int) 
{
    // Expresses the property that f is strictly increasing 
    // in both its arguments, i.e. 
    // ∀ i,j,k ∈ ℤ:
    //   if i < j then f(i,k) < f(j,k)
    //   if j < k then f(i,j) < f(i,k)
  (forall i,j,k:: i < j  ==>  f(i,k) < f(j,k)) &&
  (forall i,j,k:: j < k  ==>  f(i,j) < f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(g:(int,int) -> int, x:nat, y:nat, m:nat): int
requires IncrIncr(g)
decreases (m - x) + y
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(g,x,y,m) = #{ (i,j) | i,j: x ≤ i < m ∧ 0 ≤ j < y ∧ g(i,j) = j }
    // This function counts the number of points in the rectangle [x,m) × [0,y)
    // that satisfy g(i,j) = j. 
    // Base case: x ≥ m or y ≤ 0, then the rectangle is empty and F(g,x,y,m) = # ∅ = 0.
    // Recursive case: in this case we want to shrink the rectangle by either 
    //                 incrementing x or decrementing y
    // 
    // What happens if we increment x?
    //   F(g,x,y,m) 
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ 0 ≤ j < y ∧ g(i,j) = j }
    //        ( split domain into x + 1 ≤ i < m and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i < m ∧ 0 ≤ j < y ∧ g(i,j) = j }
    //     + #{ (x,j) | j: 0 ≤ j < y ∧ g(x,j) = j }
    //       ( apply definition of F to the first term )
    //   = F(g,x+1,y,m) + #{ (x,j) | j: 0 ≤ j < y ∧ g(x,j) = j }
    //       ( g(x,j) is strictly increasing in j, so the value of
    //         g(x,y-1) is maximal, so if we assume g(x,y-1) < y-1,
    //         then g(x,j) < j for all 0 ≤ j < y and we can discard 
    //         the whole column x as it contains no matching points )
    //   = F(g,x+1,y,m) + # ∅
    //   = F(g,x+1,y,m)  
    //
    // What happens if we decrement y?
    //   F(g,x,y,m)
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ 0 ≤ j < y ∧ g(i,j) = j }
    //        ( split domain into 0 ≤ j < y-1 and j = y-1 )
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ 0 ≤ j < y-1 ∧ g(i,j) = j }
    //     + #{ (i,y-1) | i: x ≤ i < m ∧ g(i,y-1) = y-1 }
    //       ( apply definition of F to the first term )
    //   = F(g,x,y-1,m) + #{ (i,y-1) | i: x ≤ i < m ∧ g(i,y-1) = y-1 }
    //       ( g(i,y-1) is strictly increasing in i, so the value of 
    //         g(x,y-1) is minimal; so if we assume g(x,y-1) ≥ y-1, 
    //         then either g(x,y-1) = y-1 ( one matching point in row y-1 )
    //         or g(i,y-1) > y-1 for all x ≤ i < m, and then we can discard 
    //         the whole row y-1 )
    //   = F(g,x,y-1,m) + ord(g(x,y-1) == y-1)
  if x >= m || y <= 0 then 0
  else if g(x, y - 1) < y - 1 then F(g, x + 1, y, m)
  else F(g, x, y - 1, m) + ord(g(x, y - 1) == y - 1)
}

method problem04(g:(int,int) -> int, m:nat, n:nat) 
returns (r: int)
requires IncrIncr(g)
ensures r == F(g, 0, n, m)
{
    // Initialization to establish J before the loop
    // P: F(g,0,n,m) = Z
    //   ( arithmetic )
    // 0 + F(g,x,y,m) = F(g,0,n,m)
  var x, y, z := 0, n, 0;
    // J: z + F(g,x,y,m) = F(g,0,n,m) 

  while x < m && y > 0
  invariant z + F(g,x,y,m) == F(g,0,n,m)
  decreases (m - x) + y
  {   
      // J ∧ B ∧ vf = V
      // z + F(g,x,y,m) = F(g,0,n,m) ∧ x < m ∧ y > 0 ∧ (m - x) + y = V
      //   ( we want to apply the recursive definition of F, so we need
      //     to distinguish the cases g(x,y-1) < y-1 and g(x,y-1) ≥ y-1 )

    if g(x, y - 1) < y - 1
    {   
        // z + F(g,x,y,m) = F(g,0,n,m) ∧ g(x,y-1) < y-1 ∧ x < m ∧ y > 0 ∧ (m - x) + y = V
        //   ( apply definition of F; since x < m ∧ y > 0, we are in the recursive case )
        // z + F(g,x+1,y,m) = F(g,0,n,m) ∧ (m - x) + y = V
        //   ( prepare for incrementing x )
        // z + F(g,x+1,y,m) = F(g,0,n,m) ∧ (m - (x + 1)) + y < V
      x := x + 1;
        // z + F(g,x,y,m) = F(g,0,n,m) ∧ (m - x) + y < V
    }

    else
    { 
        // z + F(g,x,y,m) = F(g,0,n,m) ∧ g(x,y-1) ≥ y-1 ∧ x < m ∧ y > 0 ∧ (m - x) + y = V
        //   ( apply definition of F; since x < m ∧ y > 0, we are in the recursive case )
        // z + F(g,x,y-1,m) + ord(g(x,y-1) == y-1) = F(g,0,n,m) ∧ (m - x) + y = V
      z := z + ord(g(x, y - 1) == y - 1);
        // z + F(g,x,y-1,m) = F(g,0,n,m) ∧ (m - x) + y = V
        //   ( prepare for decrementing y )
        // z + F(g,x,y-1,m) = F(g,0,n,m) ∧ (m - x) + (y - 1) < V
      y := y - 1;
        // z + F(g,x,y,m) = F(g,0,n,m) ∧ (m - x) + y < V
    }

      // Collect branches:
      // z + F(g,x,y,m) = F(g,0,n,m) ∧ (m - x) + y < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function vf has decreased )
  }
    
    // J ∧ ¬B
    // z + F(g,x,y,m) = F(g,0,n,m) ∧ (x >= m ∨ y <= 0)
    //   ( since x ≥ m ∨ y ≤ 0, we are in the base case of F )
    // z + 0 = F(g,0,n,m)
    // z = F(g,0,n,m)
  r := z;
    // r = F(g,0,n,m)
    // Q: r = Z
}