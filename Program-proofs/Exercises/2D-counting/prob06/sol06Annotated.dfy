/* file: sol06Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob06, with annotations
   This is exercise 9.7 from the PC reader
*/

ghost predicate IncrDesc(f:(nat,nat) -> int) 
{
    // Expresses the property that f is increasing in its first  
    // argument and descending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℕ:
    //   if i < j then f(i,k) < f(j,k)
    //   if j ≤ k then f(i,j) ≥ f(i,k)
  (forall i,j,k:: i <  j  ==>  f(i,k) <  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(g:(nat,nat) -> int, x:nat, y:nat, n:nat, w:int): int
requires IncrDesc(g)
decreases n - (x + y)
{   
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as:
    //   F(g,x,y,n,w) = #{ (i,j) | i,j: x ≤ i < n ∧ y ≤ j < n ∧ i + j < n ∧ g(i,j) = w }
    // This function counts the number of points in the triangle marked by
    //  { (i,j) | x ≤ i < n ∧ y ≤ j < n ∧ i + j < n } that satisfy g(i,j) = w
    // In the initial call F(g,0,0,n,w), this is the full triangle
    //  { (i,j) | 0 ≤ i < n ∧ 0 ≤ j < n ∧ i + j < n }.
    //
    // Base case: x + y ≥ n then the triangle is empty and F(g,x,y,n,w) = # ∅ = 0
    //
    // Recursive case: in this case we want to shrink the triangle by either 
    //                 incrementing x (which removes the leftmost column) or 
    //                 incrementing y (which removes the bottommost row)
    // What happens if we increment x?
    //   F(g,x,y,n,w)
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ y ≤ j < n ∧ i + j < n ∧ g(i,j) = w }
    //        ( split domain into x + 1 ≤ i < n and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i < n ∧ y ≤ j < n ∧ i + j < n ∧ g(i,j) = w }
    //     + #{ (x,j) | j: y ≤ j < n ∧ x + j < n ∧ g(x,j) = w }
    //        ( apply definition of F to the first term )
    //   = F(g,x+1,y,n,w) + #{ (x,j) | j: y ≤ j < n ∧ x + j < n ∧ g(x,j) = w }
    //        ( g(x,j) is descending in j, so the value of g(x,y) is maximal;
    //          if we assume g(x,y) < w, then g(x,j) ≤ g(x,y) < w for all j 
    //          with y ≤ j < n and x + j < n, so that we can discard the whole 
    //          column as it contains no matching points )
    //   = F(g,x+1,y,n,w) + # ∅
    //        ( size of the empty set is 0 )
    //   = F(g,x+1,y,n,w)
    //
    // What happens if we increment y?
    //   F(g,x,y,n,w)
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ y ≤ j < n ∧ i + j < n ∧ g(i,j) = w }
    //        ( split domain into y + 1 ≤ j < n and j = y )
    //   = #{ (i,j) | i,j: x ≤ i < n ∧ y + 1 ≤ j < n ∧ i + j < n ∧ g(i,j) = w }
    //     + #{ (i,y) | i: x ≤ i < n ∧ i + y < n ∧ g(i,y) = w }
    //        ( apply definition of F to the first term )
    //   = F(g,x,y+1,n,w) + #{ (i,y) | i: x ≤ i < n ∧ i + y < n ∧ g(i,y) = w }
    //        ( g(i,y) is strictly increasing in i, so the value of g(x,y) is minimal; 
    //          if we assume g(x,y) ≥ w, then only the point (x,y) can contribute to 
    //          the count. If g(x,y) = w, it contributes one; but if g(x,y) > w, 
    //          then the whole row contains no matching points and we can discard it )
    //   = F(g,x,y+1,n,w) + ord(g(x,y) = w)

  if x + y >= n then 0
  else if g(x, y) < w then F(g, x + 1, y, n, w)
  else F(g, x, y + 1, n, w) + ord(g(x, y) == w)
}

method problem06(g:(nat,nat) -> int, n:nat, w:int) 
returns (r: int)
requires IncrDesc(g)
ensures r == F(g,0,0,n,w)
{
    // Initialization to establish J before the loop
    // P: F(g,0,0,n,w) = Z
    //   ( arithmetic )
    // 0 + F(g,0,0,n,w) = F(g,0,0,n,w)
  var x, y, z := 0, 0, 0;
    // J: z + F(g,x,y,n,w) = F(g,0,0,n,w)

  while x + y < n
  invariant z + F(g,x,y,n,w) == F(g,0,0,n,w)
  decreases n - (x + y)
  {   
      // J ∧ B ∧ vf = V
      // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ x + y < n ∧ n - (x + y) = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases g(x,y) < w and g(x,y) ≥ w )

    if g(x, y) < w
    {
        // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ g(x,y) < w ∧ x + y < n ∧ n - (x + y) = V
        //   ( apply definition of F )
        // z + F(g,x+1,y,n,w) = F(g,0,0,n,w) ∧ n - (x + y) = V
        //   ( prepare incrementing x )
        // z + F(g,x+1,y,n,w) = F(g,0,0,n,w) ∧ n - ((x + 1) + y) < V
      x := x + 1;
        // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ n - (x + y) < V
    }

    else
    {
        // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ g(x,y) ≥ w ∧ x + y < n ∧ n - (x + y) = V
        //   ( apply definition of F )
        // z + F(g,x,y+1,n,w) + ord(g(x,y) = w) = F(g,0,0,n,w) ∧ n - (x + y) = V
      z := z + ord(g(x, y) == w);
        // z + F(g,x,y+1,n,w) = F(g,0,0,n,w) ∧ n - (x + y) = V
        //   ( prepare incrementing y )
        // z + F(g,x,y+1,n,w) = F(g,0,0,n,w) ∧ n - (x + (y + 1)) < V
      y := y + 1;
        // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ n - (x + y) < V
    } 

      // Collect branches: 
      // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ n - (x + y) < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function decreases )
  }
    
    // J ∧ ¬B
    // z + F(g,x,y,n,w) = F(g,0,0,n,w) ∧ x + y ≥ n
    //   ( apply definition of F; since x + y ≥ n, we are in the base case )
    // z + 0 = F(g,0,0,n,w)
    // z = F(g,0,0,n,w)
  r := z;
    // r = F(g,0,0,n,w)
    // Q: r = Z
}