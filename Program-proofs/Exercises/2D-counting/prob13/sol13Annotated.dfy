/* file: sol13Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D-counting, 
   solution to prob13, with annotations
   This is exercise 9.15 from the PC reader
   NOTE: The loop is machine-verified against the recursive definition of F. 
    The connection between F(f,0,0,a,n) and the set-based specification from the 
    problem statement is manually derived and justified in the comments, but 
    not machine-verified. This avoids the additional technical machinery that 
    would be needed in Dafny to introduce the corresponding finite sets, 
    reason about their cardinalities, and prove the equivalence of the 
    set-based specification and the recursive definition of F. It also keeps 
    the solution in line with the PC lecture notes.
*/

ghost predicate pos(f: (nat) -> nat)
{
    // Expresses the property that f is a positive function, 
    // i.e. f(k) > 0 for all k in the domain of f.
  (forall k:: f(k) > 0)
}

function ord(b:bool): nat
{
  if b then 1 else 0
}

ghost function F(f: (nat) -> nat, x: nat, y: nat, a: nat, n: nat): nat
requires pos(f)
requires 0 < a 
decreases 2 * n - y - x
{
    // We want to find a recursive definition of F that we can use to derive T.
    // We define F as follows:
    //   F(f,x,y,a,n) 
    //      = #{ (i,j) | i,j: x ≤ i ≤ j < n ∧ y ≤ j ∧ a = ∑( f(k) | k: i ≤ k < j ) }
    //      = #{ (i,j) | i,j: x ≤ i ≤ j < n ∧ y ≤ j ∧ a = S(f,i,j) }
    //
    // In other words, F(f,x,y,a,n) counts the number of remaining half-open intervals 
    // [i,j) for which the sum of the values of f on the interval equals a. 
    // In the initial call F(f,0,0,a,n), this is the full search region from the 
    // problem statement.
    //
    // Base case: if y ≥ n or x ≥ n, then the remaining search area is empty, 
    //   so F(f,x,y,a,n) = # ∅ = 0.
    // Recursive case: here we want to shrink the remaining search area by 
    //   - either incrementing x (which removes the leftmost element) 
    //   - or incrementing y (which adds a new rightmost element)
    //
    // What happens if we increment x?
    //   F(f,x,y,a,n)
    //   = #{ (i,j) | i,j: x ≤ i ≤ j < n ∧ y ≤ j ∧ a = S(f,i,j) }
    //        ( split domain into x + 1 ≤ i and i = x )
    //   = #{ (i,j) | i,j: x + 1 ≤ i ≤ j < n ∧ y ≤ j ∧ a = S(f,i,j) }
    //     + #{ (x,j) | j: x ≤ j < n ∧ y ≤ j ∧ a = S(f,x,j) }
    //        ( apply definition of F to the first term )
    //   = F(f,x+1,y,a,n) + #{ (x,j) | j: x ≤ j < n ∧ y ≤ j ∧ a = S(f,x,j) }
    //        ( below we assume that S(f,x,y) ≥ a; since a > 0, the interval
    //          [x,y) is non-empty, and hence x < y )
    //   = F(f,x+1,y,a,n) + #{ (x,j) | j: x ≤ y ≤ j < n ∧ a = S(f,x,j) }
    //        ( S(f,x,j) is increasing in j, so the value of S(f,x,y) is minimal;
    //          if we assume S(f,x,y) ≥ a, then only the interval [x,y) can sum 
    //          to a, since S(f,x,j) > S(f,x,y) ≥ a for all j > y. Hence, we can 
    //          increment the count by 1 iff S(f,x,y) = a, or ignore all intervals 
    //          starting at x if S(f,x,y) > a )
    //   = F(f,x+1,y,a,n) + (S(f,x,y) = a ? 1 : 0)
    //
    // What happens if we increment y?
    //   F(f,x,y,a,n)
    //   = #{ (i,j) | i,j: x ≤ i ≤ j < n ∧ y ≤ j ∧ a = S(f,i,j) }
    //        ( split domain into y + 1 ≤ j and j = y )
    //   = #{ (i,j) | i,j: x ≤ i ≤ j < n ∧ y + 1 ≤ j ∧ a = S(f,i,j) }
    //     + #{ (i,y) | i: x ≤ i ≤ y < n ∧ a = S(f,i,y) }
    //        ( apply definition of F to the first term )
    //   = F(f,x,y+1,a,n) + #{ (i,y) | i: x ≤ i ≤ y < n ∧ a = S(f,i,y) }
    //        ( S(f,i,y) is decreasing in i, so the value of S(f,x,y) is maximal;
    //          if we assume S(f,x,y) < a, then S(f,i,y) ≤ S(f,x,y) < a for all
    //          i with x ≤ i ≤ y, and hence we can ignore all intervals ending at y
    //          as they cannot sum to a )
    //   = F(f,x,y+1,a,n) + # ∅
    //        ( size of the empty set is 0 )
    //   = F(f,x,y+1,a,n)
  if y >= n || x >= n then 0
  else if S(f,x,y) >= a 
       then F(f,x+1,y,a,n) + ord(S(f,x,y) == a)
       else F(f,x,y+1,a,n)
}

ghost function S(f: (nat) -> nat, x: nat, y: nat): nat
decreases y - x
{
    // We define S(f,x,y) = ∑( f(k) | k: x ≤ k < y )
    // Base case: if x ≥ y, then the sum is empty, so S(f,x,y) = 0.
    // Recursive case: if x < y, then we can split the non-empty domain 
    //   and derive the recursive case as follows:
    //  S(f,x,y)
    //    = ∑( f(k) | k: x ≤ k < y )
    //        ( split domain into x + 1 ≤ k < y and k = x )
    //    = ∑( f(k) | k: x + 1 ≤ k < y ) + f(x)
    //        ( apply definition of S to the first term )
    //    = S(f,x+1,y) + f(x)
  if x >= y then 0 else f(x) + S(f,x+1,y)
}

lemma incrS(f: (nat) -> nat, x: nat, y: nat)
requires x <= y
ensures S(f,x,y+1) == S(f,x,y) + f(y)
decreases y - x
{
    // We prove the lemma by induction on the length of the 
    // half-open interval [x,y), l = y - x.
    // The statement to prove is: S(f,x,y+1) = S(f,x,y) + f(y)
    //
    // That is: extending the upper bound of the half-open interval
    // [x,y) by one adds exactly the new last value f(y).
    //
    // Base case, l = 0: then x = y, and we have:
    //   S(f,x,y+1) = S(f,y,y+1) = f(y) = 0 + f(y) 
    //              = S(f,y,y) + f(y) = S(f,x,y) + f(y)
    //
    // Inductive step, l > 0:
    //   To prove: S(f,x,y+1) = S(f,x,y) + f(y)
    //   The induction hypothesis (IH) states that the lemma holds for 
    //   the smaller interval [x+1,y): S(f,x+1,y+1) = S(f,x+1,y) + f(y)
    //
    //   We start from the left-hand side of the statement to prove,
    //   and obtain the right-hand side as follows:
    //     S(f,x,y+1) 
    //     = { apply definition of S }
    //       f(x) + S(f,x+1,y+1)
    //     = { apply IH }
    //       f(x) + S(f,x+1,y) + f(y)
    //     = { apply definition of S backwards }
    //       S(f,x,y) + f(y)

    // The actual proof in Dafny only requires the recursive call on the 
    // smaller interval [x+1,y), in order to apply the induction hypothesis 
    // and prove the lemma for the larger interval [x,y). In the base case
    // where x = y, Dafny can prove the postcondition directly by unfolding
    // the definition of S.
  if x < y 
  {
    incrS(f,x+1,y);
  }
}

method problem13(f: (nat) -> nat, a: nat, n: nat)
returns (r: nat)
requires 0 < a && 0 < n
requires pos(f)
ensures r == F(f,0,0,a,n)
{
    // Initialization to establish J before the loop
    // P: F(f,0,0,a,n) = Z
    //   ( arithmetic )
    // 0 + F(f,0,0,a,n) = Z ∧ 0 = S(f,0,0)
  var x, y, z, s := 0, 0, 0, 0;
    // J: z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y)

  while x < n && y < n
  invariant 0 <= x <= y <= n
  invariant z + F(f,x,y,a,n) == F(f,0,0,a,n) && s == S(f,x,y)
  decreases 2 * n - x - y
  {
      // J ∧ B ∧ vf = V
      // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ x < n ∧ y < n ∧ 2 * n - x - y = V
      //   ( we want to apply the definition of F. Since we are not in the base case,
      //     we need to distinguish the recursive cases S(f,x,y) ≥ a and S(f,x,y) < a )

    if s >= a
    {
        // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ S(f,x,y) ≥ a 
        //   ∧ x < n ∧ y < n ∧ 2 * n - x - y = V
        //   ( apply definition of F )
        // z + F(f,x+1,y,a,n) + (S(f,x,y) = a ? 1 : 0) = Z ∧ s = S(f,x,y)
        //   ∧ 2 * n - x - y = V
      z := z + ord(s == a);
        // z + F(f,x+1,y,a,n) = Z ∧ s = S(f,x,y) ∧ 2 * n - x - y = V
        //   ( apply definition of S to update s; the recursive case of S is applicable
        //     since x < y, which follows from S(f,x,y) ≥ a > 0 )
        // z + F(f,x+1,y,a,n) = Z ∧ s - f(x) = S(f,x+1,y) ∧ 2 * n - x - y = V
      s := s - f(x);
        // z + F(f,x+1,y,a,n) = Z ∧ s = S(f,x+1,y) ∧ 2 * n - x - y = V
        //   ( prepare for incrementing x )
        // z + F(f,x+1,y,a,n) = Z ∧ s = S(f,x+1,y) ∧ 2 * n - (x + 1) - y < V
      x := x + 1;
        // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ 2 * n - x - y < V
    }

    else
    {
        // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ S(f,x,y) < a 
        //   ∧ x < n ∧ y < n ∧ 2 * n - x - y = V
        //   ( apply definition of F )
        // z + F(f,x,y+1,a,n) = Z ∧ s = S(f,x,y) ∧ 2 * n - x - y = V
        //   ( apply lemma incrS which states that S(f,x,y+1) = S(f,x,y) + f(y);
        //     the lemma is required since the definition of S is not directly 
        //     applicable to the case where the second argument is incremented )
      incrS(f,x,y);
        // z + F(f,x,y+1,a,n) = Z ∧ s + f(y) = S(f,x,y+1) ∧ 2 * n - x - y = V 
      s := s + f(y);
        // z + F(f,x,y+1,a,n) = Z ∧ s = S(f,x,y+1) ∧ 2 * n - x - y = V
        //   ( prepare for incrementing y )
        // z + F(f,x,y+1,a,n) = Z ∧ s = S(f,x,y+1) ∧ 2 * n - x - (y + 1) < V
      y := y + 1;
        // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ 2 * n - x - y < V
    }

      // Collect branches:
      // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ 2 * n - x - y < V
      // J ∧ vf < V
      //   ( J is preserved and the variant function decreases )
  
  }

    // J ∧ ¬B
    // z + F(f,x,y,a,n) = Z ∧ s = S(f,x,y) ∧ (x ≥ n ∨ y ≥ n) 
    //   ( apply base case of F )
    // z + 0 = Z ∧ s = S(f,x,y)
  r := z;
    // Q: r = Z
}