/*  file: sol05.dfy
    author: David De Potter
    description: proof by induction of the formula for a finite
    geometric sum
*/

//========================================================================
// Recursively defines r^n.
ghost function Pow(r:int, n:nat): int
  decreases n
{
  if n == 0 then 1
            else Pow(r,n-1) * r
}

//========================================================================
// Recursively defines the finite geometric sum:
//   GeometricSum(a,r,n) = ∑(a*r^i | i: 0 ≤ i < n)
ghost function GeometricSum(a:int, r:int, n:nat): int
  decreases n
{
  if n == 0 then 0
            else GeometricSum(a,r,n-1) + a * Pow(r,n-1)
}

//========================================================================
// Proves the following division-free geometric-sum identity:
//   (1-r) * GeometricSum(a,r,n) = a * (1-r^n)
// This identity holds for every integer r. When r ≠ 1, it is the
// division-free form of the usual finite geometric-sum formula.
lemma {:induction false} GeometricSumFormula(a:int, r:int, n:nat)
  ensures (1-r) * GeometricSum(a,r,n) == a * (1-Pow(r,n))
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true
    assert (1-r) * GeometricSum(a,r,0) == a * (1-Pow(r,0)) by
    {
      calc
      {
        (1-r) * GeometricSum(a,r,0);
          // Unfold GeometricSum(a,r,0)
        == (1-r) * 0;
          // Arithmetic
        == 0;
          // Arithmetic
        == a * 0;
          // Arithmetic
        == a * (1-1);
          // Fold Pow(r,0)
        == a * (1-Pow(r,0));
      }
    }
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   (1-r) * GeometricSum(a,r,n-1) = a * (1-r^(n-1))
    GeometricSumFormula(a,r,n-1);
      
      // Abbreviate Pow(r,n-1) as p 
      // to simplify the calculation below
    var p := Pow(r,n-1);

      // Induction step
      // Prove Q(n) is true
    calc
    {
      (1-r) * GeometricSum(a,r,n);
        // Unfold GeometricSum(a,r,n)
      == (1-r) * (GeometricSum(a,r,n-1) + a * p);
        // Distribute 1-r over the sum
      == (1-r) * GeometricSum(a,r,n-1) + (1-r) * a * p;
        // Apply the induction hypothesis
      == a * (1-p) + (1-r) * a * p;
        // Factor out a
      == a * ((1-p) + (1-r) * p);
        // Simplify the expression inside the parentheses
      == a * (1 - p*r);
        // Rewrite p * r = Pow(r,n-1) * r = Pow(r,n)
      == a * (1-Pow(r,n));
    }
  }
  
}