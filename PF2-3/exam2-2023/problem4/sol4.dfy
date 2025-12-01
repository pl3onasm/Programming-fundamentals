/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd exam 2023, solution to problem 4
*/

method problem4(a: int, b: int, c: int) returns (i: int, j: int, k: int)
  requires a <= b <= c
  ensures i == j == k
{
  i, j, k := a, b, c;

  /* 
    Idea:
    We start from three integers a <= b <= c, and we want to end
    with three equal integers i, j, k.

    This is expressed by the loop condition, which tests whether
    at least one of the inequalities i < j or j < k still holds.
    When that is the case, we increment the smaller of the two 
    values involved in the inequality, so as to reduce the gap
    between them. Thus, we keep pushing the smaller values upwards 
    until they all become equal.

    To prove correctness, we need to provide:
      (1) a suitable loop invariant
      (2) a suitable variant (decreasing measure) to show termination

    (1) The invariant we use is: i <= k  and  j <= k

      This captures that k is always at least as large as i and j.
      Initially, from a <= b <= c and i = a, j = b, k = c we have:
        i <= j <= k  ⇒  i <= k and j <= k,
      so the invariant holds at the start.

    (2) As a variant, we choose: 2 * k - i - j

      Note that this variant can be seen as the sum of the two gaps
      between k and the other two variables:
        (k - i) + (k - j) = 2*k - i - j

      This is always non-negative, and strictly decreases on every 
      reachable iteration of the loop, so the loop must terminate.
      
      Initially:
        a <= b <= c  ⇒  a + b <= 2*c  ⇒  2*c - a - b >= 0,
      so the variant starts non-negative.

      - If i < j, we do i := i + 1, so:
          (k - i) decreases by 1, (k - j) unchanged
          ⇒ the total sum decreases by 1

      - If i >= j and j < k, we do j := j + 1, so:
          (k - j) decreases by 1, (k - i) unchanged
          ⇒ the total sum again decreases by 1

      The third branch (k := k + 1) is actually unreachable,
      because it would require i >= j and j >= k,
      which contradicts the loop condition (i < j || j < k).
  */

  while i < j || j < k
    invariant i <= k && j <= k
    decreases 2 * k - i - j
  {
    if i < j {
        // Here i < j, so we increase i to reduce the gap (k - i)
      i := i + 1;
    } else {
        // Here we know i >= j
      if j < k {
          // i >= j and j < k: increase j to reduce the gap (k - j)
        j := j + 1;
      } else {
          // This branch is unreachable and so k is never updated.
        k := k + 1;
      }
    }
  }

  /* When the loop terminates, the condition
     i < j || j < k is false, so we have:
       i >= j  and  j >= k
     Combined with the invariant i <= k and j <= k, we get:
       i <= k  and  i >= j >= k
     Hence:
       i == j == k
     and the postcondition holds.
  */
}