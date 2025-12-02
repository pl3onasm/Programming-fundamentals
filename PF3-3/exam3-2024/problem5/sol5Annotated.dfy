/* 
  file: sol5Annotated.dfy
  author: David De Potter
  description: 3-3rd exam 2024, solution to problem 5
               with detailed annotations
*/

method problem5(a: array<int>) returns (k: nat)
  requires a.Length > 1 && a[0] == a[a.Length-1]
  ensures 0 <= k < a.Length - 1 && a[k] >= a[k+1]
{
  var i, j := 0, a.Length - 1;

  /* 
    Idea:
    We are given an array a of length > 1 such that:

        a[0] == a[a.Length - 1]

    We want to find an index k such that:

        0 <= k < a.Length - 1  and  a[k] >= a[k+1]

    In other words, we want to find a position k where
    the array is non-increasing from a[k] to a[k+1].

    It is guaranteed that such a k exists because of the
    precondition a[0] == a[a.Length - 1]. After all, if
    the array were strictly increasing at every adjacent
    pair, we would have:

        a[0] < a[1] < a[2] < ... < a[a.Length - 1],

    which contradicts a[0] == a[a.Length - 1]. So there
    must be at least one position where the array is
    non-increasing.

    The given program uses a binary-search approach on 
    indices i and j, which mark a current interval [i, j] 
    containing a non-increasing pair. We maintain i < j 
    and search until the interval shrinks to length 2, 
    i.e. j == i + 1. Then we can take k = i.

    So, the program continues as long as i + 1 < j,
    which means the interval [i, j] has length at least 3.

    Inside the loop, we compute the current midpoint:

      m = (i + j) / 2

    and compare a[i] and a[m]:

      • If a[i] < a[m], then since a[i] >= a[j]
        (from the invariant given below), we have:

            a[m] > a[i] >= a[j]

        so a[m] >= a[j]. Therefore, the non-increasing
        pair must be in the right half [m, j], and we
        can move the left bound up to m:   i := m

      • If a[i] >= a[m], then the non-increasing pair
        must be in the left half [i, m], so we move
        the right bound down to m:         j := m


    To prove correctness, we still have to provide:
      (1) a suitable loop invariant
      (2) a suitable variant to show termination

    (1) We select the following two invariants:

        invariant 0 <= i < j <= a.Length - 1  
        invariant a[i] >= a[j]

      • The first invariant says that [i, j] is always a 
        valid, non-empty interval inside the array, with 
        at least 2 elements.

        Initially, we have: i = 0, j = a.Length - 1.
        From the precondition a.Length > 1, we obtain:
          0 <= i < j <= a.Length - 1 
        Thus, the first invariant holds at the start.

      • The second invariant says that the value at the left 
        end of the interval is always at least as large as the 
        value at the right end:  a[i] >= a[j]

        Initially, we have:
          i = 0, j = a.Length - 1 and a[0] == a[a.Length - 1]
          by the precondition. So:
            a[i] == a[j]  ⇒  a[i] >= a[j]
          and the invariant holds at the start.

    (2) As a variant, we choose the length of the current 
        interval:  j - i

      • Non-negativity:
          From 0 <= i < j <= a.Length - 1 we have j - i >= 1, so the
          variant is always a positive nat while the loop runs.

      • Strict decrease:
          In each iteration we set either i := m or j := m, where
          m = (i + j) / 2 satisfies i < m < j. It is easy to see 
          that this implies:

            j - m < j - i   if we set i := m
            m - i < j - i   if we set j := m

          So in either case, the new value of the variant is
          strictly less than its old value.

      From non-negativity and strict decrease, it follows that
      the loop must terminate.
  */

  while i + 1 < j
    invariant 0 <= i < j <= a.Length - 1  
    invariant a[i] >= a[j]
    decreases j - i
  {
    var m := (i + j) / 2;

    if a[i] < a[m] 
    {
      /* 
        We have a[i] < a[m] and a[i] >= a[j] ⇒ a[m] > a[i] >= a[j],
        so a[m] >= a[j]. We move the left bound up to m, and leave
        the right bound j unchanged: i' = m, j' = j
        Thus, the new interval has been reduced to [m, j],
        and the invariant has been restored: a[i'] >= a[j']
      */
      i := m;
    } 
    
    else 
    {
      /* 
        We have a[i] >= a[m]. We move the right bound down to m,
        and leave the left bound i unchanged: i' = i, j' = m
        Thus, the new interval has been reduced to [i, m],
        and the invariant has been restored: a[i'] >= a[j']
      */
      j := m;
    }
  }

  /*  
    At loop exit, the invariants still hold:

      (1) 0 <= i < j <= a.Length - 1
      (2) a[i] >= a[j]

    The loop guard, on the other hand, is false, so:

      (3) j <= i + 1

    Combining (1) and (3):  i < j <= i + 1

    implies:                j == i + 1

    Thus, at loop exit, the interval [i, j] has length 2,
    with j == i + 1
    From (2) we have a[i] >= a[j], so we can satisfy the
    postcondition by setting k := i
  */

  k := i;
}
 