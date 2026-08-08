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
// To avoid reasoning about integer division, the lemma proves the
// equivalent division-free form of the geometric sum formula:
//   (1-r) * GeometricSum(a,r,n) = a * (1-r^n)
lemma {:induction false} GeometricSumFormula(a:int, r:int, n:nat)
  ensures (1-r) * GeometricSum(a,r,n) == a * (1-Pow(r,n))
  decreases n
{
  if n == 0
  {
      // Base case: Q(0) is true
    assert (1-r) * GeometricSum(a,r,0) == a * (1-Pow(r,0));
  }

  else
  {
      // Induction hypothesis
      // Assume Q(n-1) is true:
      //   (1-r) * GeometricSum(a,r,n-1) = a * (1-r^(n-1))
    GeometricSumFormula(a,r,n-1);

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