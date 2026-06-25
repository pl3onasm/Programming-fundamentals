/* file: sol15Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting,
   solution to prob15, with annotations
   This is exercise 9.17 from the PC reader

   NOTE: The loop is machine-verified against the recursive
   definition of F. The connection between F(h,0,0,p,w)
   and the set-based specification from the problem statement is
   manually derived and justified in the comments, but not
   machine-verified. This avoids the additional technical machinery
   needed for sets and cardinalities in Dafny, and keeps the solution
   in line with the PC lecture notes.
*/

ghost predicate IncrDecr(f:(nat,nat) -> int)
{
    // Expresses the property that f is strictly increasing in its
    // first argument and strictly decreasing in its second argument,
    // i.e.
    // ∀ i,j,k ∈ ℕ:
    //   if i < j then f(i,k) < f(j,k)
    //   if j < k then f(i,j) > f(i,k)
  (forall i,j,k :: i < j ==> f(i,k) < f(j,k)) &&
  (forall i,j,k :: j < k ==> f(i,j) > f(i,k))
}

function ord(b:bool): nat
{
  if b then 1 else 0
}

ghost function F(h:(nat,nat) -> int, x:nat, y:nat, p:nat, w:int): int
requires IncrDecr(h)
requires x <= p
requires y <= p
decreases (p - x) + (p - y)
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(h,x,y,p,w) = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    // That is, F(h,x,y,p,w) counts the number of points (i,j) that lie 
    // strictly inside the quarter disk of radius √p, and for which h(i,j) = w. 
    // When this function is initially called as F(h,0,0,p,w), the remaining
    // search area is the full quarter disk.
    //
    // Base case: if x = p or y = p or x² + y² ≥ p, then the remaining search area 
    //            is empty, so F(h,x,y,p,w) = #∅ = 0.
    // Note that we use p as a coarse upper bound for x and y rather than √p, 
    // to avoid the need for square roots in the Dafny code. This does not change 
    // the counted set, because every point satisfying i² + j² < p also satisfies 
    // i < p and j < p. After an update, x or y may reach p, but then the loop stops 
    // and F uses its base case.
    //
    // Recursive case: here we want to shrink the remaining search area by 
    //   - either incrementing x (which removes the leftmost column)
    //   - or incrementing y (which removes the bottommost row)
    //
    // What happens if we increment x?
    //   F(h,x,y,p,w)
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //      ( split nonempty search domain into leftmost column and remaining area: 
    //        i = x and x + 1 ≤ i < p )
    //   = #{ (i,j) | i,j: x+1 ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w } 
    //     + #{ (x,j) | j: y ≤ j < p ∧ x² + j² < p ∧ h(x,j) = w } 
    //      ( apply definition of F to the first term )
    //   = F(h,x+1,y,p,w) + #{ (x,j) | j: y ≤ j < p ∧ x² + j² < p ∧ h(x,j) = w } 
    //      ( h is decreasing in its second argument, so the value h(x,y) is
    //        maximal for all j ≥ y in the leftmost column. Hence, if we assume 
    //        h(x,y) < w, then h(x,j) < w for all j ≥ y, and we can discard the 
    //        entire column as it does not contain any points satisfying h(i,j) = w. )
    //   = F(h,x+1,y,p,w) + # ∅
    //   = F(h,x+1,y,p,w)
    //
    // What happens if we increment y?
    //   F(h,x,y,p,w)
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w }
    //      ( split nonempty search domain into bottommost row and remaining area: 
    //        j = y and y + 1 ≤ j < p )
    //   = #{ (i,j) | i,j: x ≤ i < p ∧ y+1 ≤ j < p ∧ i² + j² < p ∧ h(i,j) = w } 
    //     + #{ (i,j) | i: x ≤ i < p ∧ j = y ∧ i² + y² < p ∧ h(i,y) = w }
    //      ( apply definition of F to the first term )
    //   = F(h,x,y+1,p,w) + #{ (i,y) | x ≤ i < p ∧ i² + y² < p ∧ h(i,y) = w } 
    //      ( h is increasing in its first argument, so the value h(x,y) is minimal 
    //        for all i ≥ x in the bottommost row. Hence, if we assume h(x,y) ≥ w,
    //        then the only point in the row that can satisfy h(i,y) = w is (x,y):
    //        we add 1 to the count iff h(x,y) = w, and we can discard the rest of
    //        the row as it does not contain any other points satisfying h(i,j) = w. )
    //   = F(h,x,y+1,p,w) + ord(h(x,y) == w)

  if x == p || y == p || x * x + y * y >= p then
    0
  else if h(x,y) < w then
    F(h, x + 1, y, p, w)
  else 
    F(h, x, y + 1, p, w) + ord(h(x,y) == w)
}

method problem15(h:(nat,nat) -> int, p:nat, w:int)
returns (z:int)
requires IncrDecr(h)
ensures z == F(h, 0, 0, p, w)
{
    // Initialization to establish J before the loop
    // P: F(h,0,0,p,w) = Z
    //   ( arithmetic )
    // 0 + F(h,0,0,p,w) = Z
  var x:nat, y:nat := 0, 0;
  z := 0;
    // J: z + F(h,x,y,p,w) = Z

  while x*x + y*y < p
    invariant 0 <= x <= p
    invariant 0 <= y <= p
    invariant z + F(h, x, y, p, w) == F(h, 0, 0, p, w)
    decreases (p - x) + (p - y)
  {
      // J ∧ B ∧ vf = V
      // z + F(h,x,y,p,w) = Z ∧ x*x + y*y < p ∧ (p - x) + (p - y) = V
      //   ( we want to apply the recursive definition of F to shrink the
      //     remaining search area, so we need to check the value of h(x,y) )

    if h(x,y) < w 
    {
        // z + F(h,x,y,p,w) = Z ∧ x*x + y*y < p ∧ h(x,y) < w ∧ (p - x) + (p - y) = V
        //   ( apply definition of F; as x*x + y*y < p, we are not in the base case )
        // z + F(h,x+1,y,p,w) = Z ∧ (p - x) + (p - y) = V
        //   ( prepare for incrementing x )
        // z + F(h,x+1,y,p,w) = Z ∧ (p - (x+1)) + (p - y) < V
      x := x + 1;
        // z + F(h,x,y,p,w) = Z ∧ (p - x) + (p - y) < V
    } 

    else 
    {
        // z + F(h,x,y,p,w) = Z ∧ x*x + y*y < p ∧ h(x,y) ≥ w ∧ (p - x) + (p - y) = V
        //   ( apply definition of F; as x*x + y*y < p, we are not in the base case )
        // z + F(h,x,y+1,p,w) + ord(h(x,y) == w) = Z ∧ (p - x) + (p - y) = V 
      z := z + ord(h(x,y) == w);
        // z + F(h,x,y+1,p,w) = Z ∧ (p - x) + (p - y) = V
        //   ( prepare for incrementing y )
        // z + F(h,x,y+1,p,w) = Z ∧ (p - x) + (p - (y+1)) < V
      y := y + 1;
        // z + F(h,x,y,p,w) = Z ∧ (p - x) + (p - y) < V
    }

      // Collect branches:
      // z + F(h,x,y,p,w) = Z ∧ (p - x) + (p - y) < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // z + F(h,x,y,p,w) = Z ∧ x*x + y*y ≥ p
    //   ( apply the base case of F )
    // z + 0 = Z 
    // Q: z = Z
}


/*
   Note on time complexity:
   Each iteration increments x or y. While the loop guard holds, we have
   x² + y² < p, which implies that x < √p and y < √p. Hence x and y
   remain bounded by √p during the active part of the search. Since at
   least one of them is increased in every iteration, the number of
   iterations is in O(√p).
*/