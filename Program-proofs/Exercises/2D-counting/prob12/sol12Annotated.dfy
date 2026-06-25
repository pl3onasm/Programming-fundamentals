/* file: sol12Annotated.dfy
author: David De Potter
description: extra practice in Dafny, 2D-counting,
solution to prob12, with annotations
This is exercise 9.14 from the PC reader

NOTE: The loop is machine-verified against the recursive
definition of F. The connection between F(h,0,n,abs(h(0,0)),m) and the
set-based specification from the problem statement is manually
derived and justified in the comments, but not machine-verified.
This avoids the additional technical machinery that would be
needed in Dafny to introduce the corresponding finite sets,
reason about their minima, and prove the equivalence between the
set-based specification and the recursive definition of F. It also
keeps the solution in line with the PC lecture notes.
*/

ghost predicate AscAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is ascending in 
    // both its arguments, i.e.
    // ∀ i,j,k ∈ ℤ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

function abs(x:int): int
{
  if x < 0 then -x else x
}

function mnm(x:int, y:int): int
{
  if x <= y then x else y
}

ghost function F(h:(int,int) -> int, x:int, y:int, z:int, m:nat): int
requires AscAsc(h)
requires 0 < m 
requires 0 <= x <= m
requires 0 <= y
decreases m - x + y
{
    // We want to find a recursive definition of F that we can use
    // to derive T.
    //
    // We define F as follows:
    //   F(h,x,y,z,m) = Min{ {z} ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y} }
    //
    // In other words, F(h,x,y,z,m) is the best value already found, 
    // namely z, minimized with the absolute values in the remaining 
    // rectangle. When this rectangle is non-empty, it is marked by the
    // north-west corner (x,y-1) and the south-east corner (m-1,0).
    //
    // In the initial call, we use z = abs(h(0,0)). It is guaranteed
    // that (0,0) is one of the points of the full rectangle, because
    // m,n > 0. Given this fact, the initial call F(h,0,n,abs(h(0,0)),m)
    // is equivalent to the set-based specification from the problem 
    // statement.
    //
    // Base case: if x ≥ m or y ≤ 0, then the remaining rectangle is 
    // empty, so the best value is simply z.
    //
    // Recursive case: here we want to shrink the remaining rectangle
    //   by either incrementing x or decrementing y.
    //
    // What happens if we increment x?
    //   F(h,x,y,z,m)
    //     = Min{ {z} ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y} }
    //          ( split domain into i = x and x+1 ≤ i < m )
    //     = Min{ {z} ∪ { |h(x,j)| | j: 0 ≤ j < y} 
    //                ∪ { |h(i,j)| | i,j: x+1 ≤ i < m ∧ 0 ≤ j < y} }
    //       ( Since h is ascending in its second argument, we have
    //         h(x,j) ≤ h(x,y-1) for all 0 ≤ j < y. If we assume
    //         h(x,y-1) < 0, then all these values are negative, and
    //         hence at least as far from 0 as h(x,y-1). Therefore
    //         the best value in column x is the corner (x,y-1) and
    //         we can update z with this value and discard the column. )
    //     = Min{ {mnm(z, abs(h(x,y-1))} 
    //                ∪ { |h(i,j)| | i,j: x+1 ≤ i < m ∧ 0 ≤ j < y} }
    //        ( apply definition of F )
    //     = F(h, x+1, y, mnm(z, abs(h(x,y-1))), m)
    //
    // What happens if we decrement y?
    //   F(h,x,y,z,m)
    //     = Min{ {z} ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y} }
    //          ( split domain into j = y-1 and 0 ≤ j < y-1 )
    //     = Min{ {z} ∪ { |h(i,y-1)| | i: x ≤ i < m} 
    //                ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y-1} }
    //       ( Since h is ascending in its first argument, we have
    //         h(i,y-1) ≥ h(x,y-1) for all x ≤ i < m. If we assume
    //         h(x,y-1) ≥ 0, then all these values are non-negative, and
    //         hence at least as far from 0 as h(x,y-1). Therefore
    //         the best value in row y-1 is the corner (x,y-1) and
    //         we can update z with this value and discard the row. )
    //     = Min{ {mnm(z, abs(h(x,y-1))} 
    //                ∪ { |h(i,j)| | i,j: x ≤ i < m ∧ 0 ≤ j < y-1} }
    //        ( apply definition of F )
    //     = F(h, x, y-1, mnm(z, abs(h(x,y-1))), m)

  if x >= m || y <= 0 then z
  else if h(x,y-1) < 0 
       then F(h, x+1, y, mnm(z, abs(h(x,y-1))), m)
       else F(h, x, y-1, mnm(z, abs(h(x,y-1))), m)
}

method problem12(h:(int,int) -> int, m:nat, n:nat)
returns (z:int)
requires AscAsc(h)
requires 0 < m && 0 < n
ensures z == F(h,0,n,abs(h(0,0)),m)
{
    // Initialization to establish J before the loop.
    // P: F(h,0,n,abs(h(0,0)),m) = Z
  var x:int, y:int := 0, n;
  z := abs(h(0,0));
    // J: F(h,x,y,z,m) = Z

  while x < m && 0 < y
  invariant 0 <= x <= m
  invariant 0 <= y <= n
  invariant F(h,x,y,z,m) == F(h,0,n,abs(h(0,0)),m)
  decreases m - x + y
  {
      // J ∧ B ∧ vf = V
      // F(h,x,y,z,m) = Z ∧ x < m ∧ 0 < y ∧ m - x + y = V
      //   ( we want to apply the recursive definition of F, so we need 
      //     to distinguish the cases h(x,y-1) < 0 and h(x,y-1) ≥ 0 )

    if h(x,y-1) < 0
    {
        // F(h,x,y,z,m) = Z ∧ x < m ∧ 0 < y ∧ h(x,y-1) < 0 ∧ m - x + y = V
        //   ( apply recursive definition of F )
        // F(h,x+1,y,mnm(z, abs(h(x,y-1))),m) = Z ∧ m - x + y = V
      z := mnm(z, abs(h(x,y-1)));
        // F(h,x+1,y,z,m) = Z ∧ m - x + y = V
        //   ( prepare for incrementing x )
        // F(h,x+1,y,z,m) = Z ∧ m - (x + 1) + y < V
      x := x + 1;
        // F(h,x,y,z,m) = Z ∧ m - x + y < V
    }

    else
    {
        // F(h,x,y,z,m) = Z ∧ x < m ∧ 0 < y ∧ h(x,y-1) ≥ 0 ∧ m - x + y = V
        //   ( apply recursive definition of F )
        // F(h,x,y-1,mnm(z, abs(h(x,y-1))),m) = Z ∧ m - x + y = V
      z := mnm(z, abs(h(x,y-1)));
        // F(h,x,y-1,z,m) = Z ∧ m - x + y = V
        //   ( prepare for decrementing y )
        // F(h,x,y-1,z,m) = Z ∧ m - x + (y - 1) < V
      y := y - 1;
        // F(h,x,y,z,m) = Z ∧ m - x + y < V
    }

      // Collect branches:
      // F(h,x,y,z,m) = Z ∧ m - x + y < V
      // J ∧ vf < V
      //   ( J is preserved, and the variant function decreases )
  }

    // J ∧ ¬B
    // F(h,x,y,z,m) = Z ∧ ¬(x < m ∧ 0 < y)
    //   ( De Morgan's law )
    // F(h,x,y,z,m) = Z ∧ (x ≥ m ∨ y ≤ 0)
    //   ( apply base case of F )
    // Q: z = Z
}