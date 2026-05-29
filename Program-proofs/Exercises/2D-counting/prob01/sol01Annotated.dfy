/* file: sol01Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, 2D counting, 
   solution to prob01, with annotations
   This is exercise 9.2 from the PC reader
*/

ghost predicate AscDesc(f:(nat,nat) -> int) 
{
    // Expresses the property that f is ascending in its first 
    // argument and descending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then f(i,k) ≤ f(j,k)
    //   if j ≤ k then f(i,j) ≥ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) <= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) >= f(i,k))
}

method problem01(h:(nat,nat) -> int, c: int, ghost X: nat, ghost Y: nat)
returns (x: nat, y: nat)
requires AscDesc(h) && h(X,Y) == c
ensures x <= X && y <= Y && h(x,y) == c 
{
    // Initialization to establish J before the loop
    // P: 0 ≤ X ∧ 0 ≤ Y ∧ h(X,Y) = c
    //   ( arithmetic )
    // 0 ≤ 0 ≤ X ∧ 0 ≤ 0 ≤ Y
  x, y := 0, 0;
    // J: 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y

  while h(x,y) != c
  invariant x <= X && y <= Y
  decreases X - x + Y - y
    // The variant function measures the remaining distance from the
    // current point (x,y) to the upper-right corner (X,Y), counted as
    // the number of horizontal and vertical steps still available.
    // In every iteration, either x or y is incremented, so either
    // X - x or Y - y decreases by one. Hence their sum strictly
    // decreases while remaining non-negative.
  {   
      // J ∧ B ∧ vf = V
      // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ h(x,y) != c ∧ X - x + Y - y = V
      //   ( h(x,y) != c ⇒ h(x,y) < c ∨ h(x,y) > c )
    if h(x,y) < c
    {
        // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ h(x,y) < c ∧ X - x + Y - y = V
        //   ( If x = X, then y ≤ Y and h is descending in its second
        //     argument, so h(x,y) = h(X,y) ≥ h(X,Y) = c,
        //     contradicting h(x,y) < c. Therefore x < X )
      assert x < X;
        // 0 ≤ x < X ∧ 0 ≤ y ≤ Y ∧ X - x + Y - y = V
        //   ( prepare for incrementing x )
        // 0 ≤ x + 1 ≤ X ∧ 0 ≤ y ≤ Y ∧ X - (x + 1) + Y - y < V
      x := x + 1;
        // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ X - x + Y - y < V
    } 
    
    else
    {
        // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ h(x,y) > c ∧ X - x + Y - y = V
        //   ( If y = Y, then x ≤ X and h is ascending in its first
        //     argument, so h(x,y) = h(x,Y) ≤ h(X,Y) = c,
        //     contradicting h(x,y) > c. Therefore y < Y )
      assert y < Y;
        // 0 ≤ x ≤ X ∧ 0 ≤ y < Y ∧ X - x + Y - y = V
        //   ( prepare for incrementing y )
        // 0 ≤ x ≤ X ∧ 0 ≤ y + 1 ≤ Y ∧ X - x + Y - (y + 1) < V
      y := y + 1;
        // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ X - x + Y - y < V
    }

      // collect branches:
      // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ X - x + Y - y < V
      // J ∧ vf < V
      //   ( J is preserved and vf has decreased )
  }

    // J ∧ ¬B
    // 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ ¬(h(x,y) != c)
    // Q: 0 ≤ x ≤ X ∧ 0 ≤ y ≤ Y ∧ h(x,y) = c
}