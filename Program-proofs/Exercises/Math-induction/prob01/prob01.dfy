/* file: prob01.dfy
   author: your name
   description: extra practice in Dafny, mathematical induction, 
   prob01
*/

ghost function SumSquares(n:nat): nat
{
  if n == 0 then 0 else SumSquares(n-1) + n*n
}

lemma {:induction false} SumSquaresFormula(n:nat)
  ensures 6 * SumSquares(n) == n * (n + 1) * (2*n + 1)
{
  /*
    Prove this lemma by mathematical induction on n.

    Dafny's automatic induction is disabled for this lemma, so you 
    need to write the induction argument explicitly:

      base case:      n = 0
      induction step: assume the formula for n-1 and prove it for n

    The formula is written without division to avoid integer-division
    side conditions. It is equivalent to the usual identity

      ∑(i² | i: 0 <= i < n) = n(n+1)(2n+1) / 6
  */
}