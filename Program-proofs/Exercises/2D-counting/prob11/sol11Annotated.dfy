/* file: sol11Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob11, with annotations
   This is exercise 9.13 from the PC reader on coincidence counting
*/

ghost predicate Incr(arr: array<int>)
reads arr
{
  forall i,j:: 0 <= i < j < arr.Length ==> arr[i] < arr[j]
}

function ord(b:bool): int
{
  if b then 1 else 0
}

ghost function F(a: array<int>, b: array<int>, x: int, y: int): int
reads a, b
requires Incr(a) && Incr(b)
requires 0 <= x <= a.Length && 0 <= y <= b.Length
decreases a.Length - x + b.Length - y
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(a,b,x,y) = #{ (i,j) | i,j: x ≤ i < m ∧ y ≤ j < n ∧ a[i] = b[j] }
    //      where m = a.Length and n = b.Length
    // That is, F(a,b,x,y) counts the number of points (i,j) in the rectangle defined by
    // the inequalities x ≤ i < m and y ≤ j < n for which a[i] = b[j] holds. 
    // In the initial call, we have F(a,b,0,0), which counts the number of matching
    // points in the full rectangle marked by the lines i = 0, i = m, j = 0, and j = n.
    //
    // Base case: if x ≥ m or y ≥ n, then the rectangle is empty, so F(a,b,x,y) = # ∅ = 0.
    // Recursive case: if x < m and y < n, we want to shrink the rectangle by either
    //                 - incrementing x (which removes the leftmost column) or
    //                 - incrementing y (which removes the bottommost row)
    //
    // What happens if we increment x?
    //   F(a,b,x,y)
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ y ≤ j < n ∧ a[i] = b[j] }
    //        ( split domain into x + 1 ≤ i and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i < m ∧ y ≤ j < n ∧ a[i] = b[j] }
    //     + #{ (x,j) | j: y ≤ j < n ∧ a[x] = b[j] }
    //        ( apply definition of F to the first term )
    //   = F(a,b,x+1,y) + #{ (x,j) | j: y ≤ j < n ∧ a[x] = b[j] }
    //        ( since b is strictly increasing, b[y] is minimal among the
    //          remaining values b[j] with j >= y. Hence, if a[x] < b[y],
    //          then a[x] < b[j] for all j >= y, and so we can discard the
    //          whole column )
    //   = F(a,b,x+1,y) + # ∅
    //   = F(a,b,x+1,y)
    //
    // What happens if we increment y?
    //   F(a,b,x,y)
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ y ≤ j < n ∧ a[i] = b[j] }
    //      ( split domain into y + 1 ≤ j and j = y )
    //   = #{ (i,j) | i,j: x ≤ i < m ∧ y + 1 ≤ j < n ∧ a[i] = b[j] }
    //     + #{ (i,y) | i: x ≤ i < m ∧ a[i] = b[y] }
    //        ( apply definition of F to the first term )
    //   = F(a,b,x,y+1) + #{ (i,y) | i: x ≤ i < m ∧ a[i] = b[y] }
    //        ( since a is strictly increasing, a[x] is minimal among the
    //          remaining values a[i] with i >= x. Hence, if a[x] >= b[y],
    //          then for all i > x we have a[i] > a[x] >= b[y]. Therefore
    //          only the point (x,y) can be a matching point in this row.
    //          We add it if a[x] = b[y], and ignore it if a[x] > b[y] )
    //   = F(a,b,x,y+1) + (a[x] = b[y] ? 1 : 0)

  if x >= a.Length || y >= b.Length 
  then 0
  else if a[x] < b[y] 
       then F(a,b,x+1,y)
       else F(a,b,x,y+1) + ord(a[x] == b[y])
}
    
method problem11(a: array<int>, b: array<int>)
returns (r: int)
requires Incr(a) && Incr(b)
ensures r == F(a,b,0,0)
{ 
  var m, n := a.Length, b.Length;

    // Initialization to establish J before the loop
    // P: F(a,b,0,0) = Z
    //   ( arithmetic )
    // 0 + F(a,b,0,0) = F(a,b,0,0) 
  var x, y, z := 0, 0, 0;
    // J: z + F(a,b,x,y) = Z

  while x < m && y < n
  invariant 0 <= x <= m && 0 <= y <= n
  invariant z + F(a,b,x,y) == F(a,b,0,0)
  decreases m - x + n - y
  {
      // J ∧ B ∧ vf = V
      // z + F(a,b,x,y) = Z ∧ x < m ∧ y < n ∧ m - x + n - y = V
      //   ( we want to apply the recursive definition of F, so we need
      //     to consider the cases a[x] < b[y] and a[x] ≥ b[y] )

    if a[x] < b[y]
    {
        // z + F(a,b,x,y) = Z ∧ x < m ∧ y < n ∧ a[x] < b[y] ∧ m - x + n - y = V
        //   ( apply definition of F )
        // z + F(a,b,x+1,y) = Z ∧ m - x + n - y = V
        //   ( prepare for incrementing x )
        // z + F(a,b,x+1,y) = Z ∧ m - (x + 1) + n - y < V
      x := x + 1;
        // z + F(a,b,x,y) = Z ∧ m - x + n - y < V
    }

    else
    {
        // z + F(a,b,x,y) = Z ∧ x < m ∧ y < n ∧ a[x] ≥ b[y] ∧ m - x + n - y = V
        //   ( apply definition of F )
        // z + F(a,b,x,y+1) + (a[x] == b[y] ? 1 : 0) = Z ∧ m - x + n - y = V
      z := z + ord(a[x] == b[y]);
        // z + F(a,b,x,y+1) = Z ∧ m - x + n - y = V
        //   ( prepare for incrementing y )
        // z + F(a,b,x,y+1) = Z ∧ m - x + n - (y + 1) < V
      y := y + 1;
        // z + F(a,b,x,y) = Z ∧ m - x + n - y < V
    }

      // Collect branches:
      // z + F(a,b,x,y) = Z ∧ m - x + n - y < V
      // J ∧ vf < V
      //   ( J is preserved, and the variant function decreases )
  }

    // J ∧ ¬B
    // z + F(a,b,x,y) = Z ∧ ¬(x < m ∧ y < n)
    //   ( apply base case of F )
    // z + 0 = Z
  r := z;
    // Q: r = Z
}