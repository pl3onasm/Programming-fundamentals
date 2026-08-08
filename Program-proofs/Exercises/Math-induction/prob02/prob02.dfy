/*  file: prob02.dfy
    author: your name
    description: extra practice in Dafny, mathematical induction, 
    prob02
*/

//========================================================================
// Recursively defines the sum of the first n odd integers:
//   SumOdd(n) = ∑(2*i - 1 | i: 1 ≤ i ≤ n)
ghost function SumOdd(n:nat): nat
  decreases n
{
  if n == 0 then 0
            else SumOdd(n-1) + 2*n - 1
}

//========================================================================
// Proves by mathematical induction that the sum of the first n odd
// integers is n²:   ∑(2*i - 1 | i: 1 ≤ i ≤ n) = n²
lemma {:induction false} SumOddFormula(n:nat)
  ensures SumOdd(n) == n*n
  decreases n
{
  /*
    Prove this lemma by induction on n.

    Base case, Q(0):
      Show that SumOdd(0) = 0²

    Induction step, Q(n-1) ⇒ Q(n):
      Assume SumOdd(n-1) = (n-1)² and prove SumOdd(n) = n²
  */
}