/* file: prob01.dfy
   author: your name
   description: extra practice in Dafny, mathematical induction, 
   prob01
*/

//========================================================================
// Recursively defines the sum of the first n squares:
//   SumSquares(n) = ∑(i² | i: 1 ≤ i ≤ n)
ghost function SumSquares(n:nat): nat
  decreases n
{
  if n == 0 then 0
            else SumSquares(n-1) + n*n
}

//========================================================================
// Proves the following formula for the sum of the first n squares by 
// induction on n:  ∑(i² | i: 1 ≤ i ≤ n) = n(n+1)(2n+1)/6
lemma {:induction false} SumSquaresFormula(n:nat)
  ensures 6 * SumSquares(n) == n * (n + 1) * (2*n + 1)
{
  /*
    Prove this lemma by mathematical induction on n.

    Dafny's automatic induction is disabled for this lemma, so you 
    need to write the induction argument explicitly.

      Base case, Q(0):
        Show that the formula is true for n = 0

      Induction step, Q(n-1) ⇒ Q(n):
        Assume the formula is true for n-1, and show that it is true for n

    The formula is written without division to avoid integer-division
    side conditions. It is equivalent to the usual identity

      ∑(i² | i: 0 ≤ i ≤ n) = n(n+1)(2n+1) / 6
  */
}