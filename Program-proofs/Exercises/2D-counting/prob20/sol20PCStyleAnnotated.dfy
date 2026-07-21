/*  file: sol20PCStyleAnnotated.dfy
    author: David De Potter
    description: extra practice in Dafny, 2D-counting,
    solution to prob20, with annotations
    This is exercise 9.22 from the PC reader
    NOTE: This solution follows the PC-style proof method described
    in the general note on proof styles (see the README in the 
    Exercises folder)
*/

ghost predicate ConvexFirst(p:(int,int) -> bool)
{
    // Expresses that p is convex in its first argument, i.e.
    // for every fixed second argument w, if p holds at two
    // horizontal endpoints x and z, then it also holds at every
    // point y between them.
    //
    // ∀ x,y,z,w ∈ ℤ:
    //   p(x,w) ∧ x ≤ y ≤ z ∧ p(z,w)  ==>  p(y,w)
  forall x,y,z,w:int :: p(x,w) && x <= y && y <= z && p(z,w) ==> p(y,w)
}

ghost predicate MonoSecond(p:(int,int) -> bool)
{
    // Expresses that p is monotonic in its second argument, i.e.
    // once p holds at height y, it also holds at every larger
    // height z.
    //
    // ∀ x,y,z ∈ ℤ:
    //   p(x,y) ∧ y ≤ z  ==>  p(x,z)
  forall x,y,z:int :: p(x,y) && y <= z ==> p(x,z)
}

ghost function F(p:(int,int) -> bool, x:nat, y:nat, v:nat): int
requires ConvexFirst(p)
requires MonoSecond(p)
requires x <= v
decreases (v - x) + y
{
    // We want to find a recursive definition of F that we can
    // use to derive T. We define F as follows:
    //
    //   F(p,x,y,v) = #{ (i,j) | x ≤ i < v ∧ 0 ≤ j < y ∧ p(i,j) }
    //
    // That is, F(p,x,y,v) counts the number of points satisfying
    // p in the current rectangle with horizontal range [x,v) and
    // vertical range [0,y). When this function is initially called 
    // as F(p,0,n,m), the remaining search area is the full 
    // rectangle marked by 0 ≤ i < m  ∧  0 ≤ j < n.
    //
    // Base case:
    // If x = v or y = 0, then the current rectangle is empty, so
    //   F(p,x,y,v) = #∅ = 0.
    //
    // Recursive case:
    // We want to shrink the current rectangle by either
    //   - incrementing x (which removes the leftmost column)
    //   - decrementing v (which removes the rightmost column)
    //   - decrementing y (which removes the topmost row)
    //
    // What happens if we increment x?
    //   F(p,x,y,v)
    // = #{ (i,j) | i,j: x ≤ i < v ∧ 0 ≤ j < y ∧ p(i,j) }
    //   ( split the domain into two disjoint subsets, one for 
    //     the leftmost column i = x and one for the remaining
    //     rectangle [x+1,v) × [0,y) )
    // = #{ (i,j) | i,j: x+1 ≤ i < v ∧ 0 ≤ j < y ∧ p(i,j) }
    //   + #{ (x,j) | j: 0 ≤ j < y ∧ p(x,j) }
    //   ( apply the definition of F to the first term )
    // = F(p,x+1,y,v) + #{ (x,j) | j: 0 ≤ j < y ∧ p(x,j) }
    //   ( if we assume p(x,y-1) is false, then by monotonicity in  
    //     the second argument, p(x,j) is false for all j < y,
    //     and the entire leftmost column can be discarded )
    // = F(p,x+1,y,v) + #∅
    // = F(p,x+1,y,v)
    //
    // What happens if we decrement v?
    //   F(p,x,y,v)
    // = #{ (i,j) | i,j: x ≤ i < v ∧ 0 ≤ j < y ∧ p(i,j) }
    //   ( split the domain into two disjoint subsets, one for 
    //     the rightmost column i = v-1 and one for the remaining 
    //     rectangle [x,v-1) × [0,y) )
    // = #{ (i,j) | i,j: x ≤ i < v-1 ∧ 0 ≤ j < y ∧ p(i,j) }
    //   + #{ (v-1,j) | j: 0 ≤ j < y ∧ p(v-1,j) }
    //   ( apply the definition of F to the first term )
    // = F(p,x,y,v-1) + #{ (v-1,j) | j: 0 ≤ j < y ∧ p(v-1,j) }
    //   ( if we assume p(v-1,y-1) is false, then by monotonicity 
    //     in the second argument, p(v-1,j) is false for all j < y,
    //     and the entire rightmost column can be discarded )
    // = F(p,x,y,v-1) + #∅
    // = F(p,x,y,v-1)
    //
    // What happens if we decrement y?
    //   F(p,x,y,v)
    // = #{ (i,j) | i,j: x ≤ i < v ∧ 0 ≤ j < y ∧ p(i,j) }
    //   ( split the domain into two disjoint subsets, one for the 
    //     topmost row j = y-1 and one for the remaining rectangle 
    //     with dimensions [x,v) × [0,y-1) )
    // = #{ (i,j) | i,j: x ≤ i < v ∧ 0 ≤ j < y-1 ∧ p(i,j) }
    //   + #{ (i,y-1) | i: x ≤ i < v ∧ p(i,y-1) }
    //   ( apply the definition of F to the first term )
    // = F(p,x,y-1,v) + #{ (i,y-1) | i: x ≤ i < v ∧ p(i,y-1) }
    //   ( if we assume p(x,y-1) and p(v-1,y-1) are both true, then by
    //     convexity in the first argument, p(i,y-1) holds for every 
    //     i with x ≤ i < v, and the entire top row can be counted )
    // = F(p,x,y-1,v) + #{ (i,y-1) | i: x ≤ i < v }
    //   ( size of half-open interval [x,v) is v - x )
    // = F(p,x,y-1,v) + (v - x)

  if x == v || y == 0 then
    0
  else if p(x,y-1) && p(v-1,y-1) then
    F(p,x,y-1,v) + (v - x)
  else if !p(x,y-1) then
    F(p,x+1,y,v)
  else
    F(p,x,y,v-1)
}

method problem20(p:(int,int) -> bool, m:nat, n:nat)
returns (z:int)
requires ConvexFirst(p)
requires MonoSecond(p)
ensures z == F(p,0,n,m)
{
    // Initialization to establish J before the loop.
    // P: F(p,0,n,m) = Z
    //   ( arithmetic )
    // 0 + F(p,0,n,m) = Z
  var x:nat, y:nat, v:nat := 0, n, m;
  z := 0;
    // J: z + F(p,x,y,v) = Z

  while x < v && y > 0
    invariant x <= v <= m
    invariant y <= n
    invariant z + F(p,x,y,v) == F(p,0,n,m)
    decreases (v - x) + y
  {
      // J ∧ B ∧ vf = V
      // z + F(p,x,y,v) = Z ∧ x < v ∧ y > 0 ∧ (v - x) + y = V
      //   ( we want to apply the recursive definition of F to the 
      //     current rectangle [x,v) × [0,y), so we inspect the two top 
      //     corners (x,y-1) and (v-1,y-1) )

    if p(x,y-1) && p(v-1,y-1)
    {
        //   ( Apply case 1: p(x,y-1) and p(v-1,y-1) both hold )
        // z + F(p,x,y-1,v) + (v - x) = Z ∧ (v - x) + y = V
      z := z + (v - x);
        // z + F(p,x,y-1,v) = Z ∧ (v - x) + y = V
        //   ( prepare for decrementing y )
        // z + F(p,x,y-1,v) = Z ∧ (v - x) + (y - 1) < V
      y := y - 1;
        // z + F(p,x,y,v) = Z ∧ (v - x) + y < V
    }

    else if ! p(x,y-1)
    {
        //   ( Apply case 2: p(x,y-1) does not hold )
        // z + F(p,x+1,y,v) = Z ∧ (v - x) + y = V
        //   ( prepare for incrementing x )
        // z + F(p,x+1,y,v) = Z ∧ (v - (x + 1)) + y < V
      x := x + 1;
        // z + F(p,x,y,v) = Z ∧ (v - x) + y < V
    }

    else
    {
        //   ( Apply case 3: p(x,y-1) holds, but p(v-1,y-1) does not hold )
        // z + F(p,x,y,v-1) = Z ∧ (v - x) + y = V
        //   ( prepare for decrementing v )
        // z + F(p,x,y,v-1) = Z ∧ ((v - 1) - x) + y < V
      v := v - 1;
        // z + F(p,x,y,v) = Z ∧ (v - x) + y < V
    }

      // Collect branches:
      // z + F(p,x,y,v) = Z ∧ (v - x) + y < V
      // J ∧ vf < V
      //   ( J is preserved, and the variant strictly decreases )
  }

    // J ∧ ¬B
    // z + F(p,x,y,v) = Z ∧ (x ≥ v ∨ y ≤ 0)
    //   ( the current rectangle is empty, so F(p,x,y,v) = 0 )
    // z + 0 = Z ∧ (x ≥ v ∨ y ≤ 0)
    // Q: z = Z
}

/*
   Note on time complexity:
   In every iteration, either x is increased, v is decreased, or y is
   decreased. The width v - x can shrink at most m times, and y can
   decrease at most n times. Therefore the number of iterations is
   O(m+n).
*/