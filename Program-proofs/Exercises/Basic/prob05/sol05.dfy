/* file: sol05.dfy
   author: David De Potter
   description: extra practice in Dafny, basic,
   solution to prob05
   This is exercise 5.1e from the PC reader
*/

method problem05(x:int, ghost X:int) returns (r:int)
requires 7 * X - 2 <= x < 7 * X + 5 
ensures  r == X
{
    // P: 7 * X - 2 ≤ x < 7 * X + 5
    //   ( Add 2 to all sides )
    // 7 * X ≤ x + 2 < 7 * X + 7
    //   ( Divide all sides by 7, which is positive, so the inequalities
    //     are preserved, see also rules 2.2 and 2.3 in the PC reader and 
    //     note that / is integer division here)
    // X ≤ (x + 2) / 7 < X + 1
  r := (x + 2) / 7;
    // X ≤ r < X + 1, and since r is an integer, it must be the case that r = X.
    // Q: r = X
}