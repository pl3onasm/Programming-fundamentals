/* file: sol4Annotated.dfy
   author: David De Potter
   description: 2-3rd resit 2023, solution to problem 4
                with annotations
*/

method problem4(a: int, b:int, c:int) returns (i: int, j: int, k: int)
  requires 0 <= a <= b <= c
  ensures i == j || j == k
{
  i, j, k := a, b, c;
  
  /* 
    Idea:
    We start from three integers 0 <= a <= b <= c, and we want to end
    with three integers i, j, k such that either i == j or j == k.
    In other words, at least two of the three final values must be equal.

    This is expressed by the loop condition: i < j < k
    Intuitively, the algorithm keeps shrinking the interval [i, k] and
    adjusting j inside it, until we can no longer have a strict chain
    i < j < k. At that point we will have i == j or j == k.

    To prove correctness, we need to provide:
      (1) a suitable loop invariant
      (2) a suitable variant to show termination

    (1) We choose the following loop invariant: i <= j && j <= k

      This captures that the three values remain ordered, with j
      staying between i and k (possibly equal to either of them).

        Initially:
            i = a, j = b, k = c, and we know 0 <= a <= b <= c,
          so:
            i <= j <= k,
          and the invariant holds at the start.

    (2) Variant (decreasing measure): 3 * k - 2 * i - j

      This can be understood as a weighted sum of gaps between k 
      and the other two variables:
        3*k - 2*i - j = (k - i) + (k - i) + (k - j)

      The gap k - i is counted twice and the gap k - j once. This
      asymmetry is deliberate: with a symmetric choice like
        (k - i) + (k - j)
      the first if-branch (when we move i up and j down) would 
      leave the variant unchanged, so we would not be able to prove
      termination. By weighting k - i more heavily, we ensure that 
      this branch also reduces the variant by 1.

      In other words, the coefficients 3, -2, -1 are chosen so that
      each reachable update in the loop body reduces the variant by
      exactly 1. Since i <= j <= k implies k - i >= 0 and k - j >= 0,
      we have 3*k - 2*i - j >= 0, so the variant is always
      non-negative and strictly decreasing, which guarantees
      termination.
  */
  
  while i < j < k
    invariant i <= j && j <= k
    decreases 3 * k - 2 * i - j
  {
    if i < j - 1 
    {
        // Here i is at least 2 smaller than j.
        // We move i up and j down to shrink the gap between them,
        // while keeping k fixed. This reduces the variant by 1.
      i := i + 1;
      j := j - 1;
    } 
    
    else 
    {
        // Here we know i >= j - 1, but still i < j < k.
        // So j is close to i; we now try to move j closer to k
        // to further shrink the overall interval [i,k] in the
        // next iteration.
      if j < k 
      {
          // i <= j < k, so increasing j moves it closer to k
          // and reduces the variant by 1.
        j := j + 1;
      } 
      else 
      {
          // This branch is unreachable under the loop condition
          // i < j < k, since it would require j >= k.
        k := k - 1;
      }
    }
  }

  /* Loop exit:
     The loop terminates when i < j < k is false.
     This means either i >= j or j >= k (or both).

     Together with the invariant i <= j <= k, we obtain:

       - If i >= j, then i <= j and i >= j imply i == j.
         In this case, i == j holds.

       - Otherwise, i < j must hold, and since i < j < k
         is false, we must have j >= k. Combined with j <= k
         from the invariant, this gives j == k.

     In all cases we have i == j or j == k, which is exactly
     the postcondition.
  */
}

