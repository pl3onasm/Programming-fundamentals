/*  file: prob05.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, prob05
*/

//========================================================================
// Recursively defines r^n.
ghost function Pow(r:int, n:nat): int
  decreases n
{
  // Define this recursive function yourself.
}

//========================================================================
// Recursively defines the finite geometric sum:
//   GeometricSum(a,r,n) = ∑(a*r^i | i: 0 ≤ i < n)
ghost function GeometricSum(a:int, r:int, n:nat): int
{
  // Define this recursive function yourself.
}

lemma {:induction false} GeometricSumFormula(a:int, r:int, n:nat)
  ensures (1-r) * GeometricSum(a,r,n) == a * (1-Pow(r,n))
{
  /*
    Prove by mathematical induction the formula for the finite geometric
    sum:

      a + ar + ar² + ... + ar^(n-1) = a(1-r^n)/(1-r), for r ≠ 1
  
    First define a recursive function GeometricSum(a,r,n) representing
    the left-hand side:
  
      GeometricSum(a,r,n) = a + ar + ar² + ... + ar^(n-1)
  
    Then prove the equivalent division-free form by induction on n:
  
      (1-r) * GeometricSum(a,r,n) = a * (1-r^n)


    Base case, Q(0):
      Show that the formula is true for n = 0

    Induction step, Q(n-1) ⇒ Q(n):
      Assume the formula is true for n-1, and show that it is true for n

  */
}