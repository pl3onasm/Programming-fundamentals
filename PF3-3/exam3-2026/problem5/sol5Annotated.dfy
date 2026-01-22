/* 
  file: sol5Annotated.dfy
  author: David De Potter
  description: 3-3rd exam 2026, solution to problem 5,
               with annotations
*/

method square(n: nat) returns (s: nat)
  ensures s == n * n
{
  s := 0;
  var i   := 0;
  var odd := 1;

  /*
    Idea:
    We compute n^2 by adding the difference between consecutive 
    squares:
    
        1^2 = 1
        2^2 = 1^2 + 3
        3^2 = 2^2 + 5
        4^2 = 3^2 + 7
        ...

    From this pattern, we see that to get from i^2 to (i+1)^2,
    we simply need to add the next odd number, which is 2*i + 1.
    The program maintains a running sum s of these odd numbers.
    After i iterations, we will have added the first i odd numbers,
    so s will equal i^2. We continue this until i reaches n, at 
    which point s will equal n^2, as required.

    The variable odd keeps track of the next odd number to add.
    It starts at 1 (the first odd number) and increases by 2 in 
    each iteration.

    We maintain the following loop invariant:
        0 <= i <= n  &&  odd == 2*i + 1  &&  s == i*i

    This invariant states:
      • i is always in the range from 0 to n, counting how many
        odd numbers have been added so far.
      • odd == 2*i + 1 ensures odd is the next odd number to 
        be added. This part is necessary to let Dafny verify both  
        the update of s (next square) and the update of odd
        (next odd number).
      • s == i*i expresses that s equals the sum of the first i odd
        numbers at the start of each loop iteration.

    We initialize the variables as follows, so the invariant holds  
    at the start:
      i   = 0
      odd = 1
      s   = 0

    Termination:
      The loop runs while i < n. In each iteration we increment
      i by 1. Since i is always <= n, it must eventually 
      reach n, and then i < n becomes false. We do not need a 
      decreases clause here, as Dafny can automatically infer
      termination from the fact that i is a nat and increases
      towards n.
  */

  while (i < n)
    invariant 0 <= i <= n && odd == 2 * i + 1 && s == i * i 
  {
    /*
      We update s, odd, and i as follows.

      1) Update of s:
          s' = s + odd
             = i^2 + (2*i + 1)           (using the invariant)
             = (i + 1)^2                 (next square)

      2) Update of odd:
          odd' = odd + 2
               = (2*i + 1) + 2           (using the invariant)
               = 2*(i + 1) + 1
               = 2*i' + 1                (next odd number, 
                                          using i' = i + 1)
      3) Update of i:
           i' = i + 1                    (i < n, so i' <= n)

      So we see that all three parts of the invariant hold again 
      for the updated values i', s', odd'.
    */

    s   := s + odd;
    odd := odd + 2;
    i   := i + 1;
  }

  /*
    At loop exit we have i < n is false, so i >= n.
    Together with the invariant 0 <= i <= n, this implies: i == n

    Using the invariant s == i*i, we obtain: s == n*n

    which is exactly the postcondition.
  */
}
