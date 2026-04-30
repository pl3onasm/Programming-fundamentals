/* file: sol10Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob10, with annotations
*/

ghost function f(n:int):int
{
  if n < 0 then 0 else n - 2 * f(n - 7)
}

method problem10(n:int) returns (r:int)
ensures  r == f(n)
{ 
    // Initialization to establish J
    // P: true
    //   ( arithmetic manipulation )
    // 0 + 1 * f(n) == f(n)
  var x, y, k := 0, 1, n;
    // x + y * f(k) == f(n) 

  while k >= 0
    invariant x + y * f(k) == f(n)
    decreases k
  {
      // J ∧ B ∧ vf = V
      // x + y * f(k) == f(n) ∧ k ≥ 0 ∧ k == V
      //   ( use definition of f for k ≥ 0 )
      // x + y * (k - 2 * f(k - 7)) == f(n) ∧ k == V
      // x + y * k - y * 2 * f(k - 7) == f(n) ∧ k == V
    x := x + y * k;
      // x - y * 2 * f(k - 7) == f(n) ∧ k == V
    y := -2 * y;
      // x + y * f(k - 7) == f(n) ∧ k - 7 < V
    k := k - 7;
      // x + y * f(k) == f(n) ∧ k < V
  }

    // J ∧ ¬B
    // x + y * f(k) == f(n) ∧ k < 0
    //   ( use definition of f for k < 0 )
    // x + y * 0 == f(n) 
    // x == f(n) 
  r := x;
    // Q: r == f(n)
}