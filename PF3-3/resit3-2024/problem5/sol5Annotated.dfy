/* 
  file: sol5Annotated.dfy
  author: David De Potter
  description: 3-3rd resit exam 2024, solution to problem 5,
               with annotations
*/

method problem5(x: int, y: int) returns (z: int)
  requires y >= 0
  ensures z == x * y
{
  var a := x;
  var b := y;
  z := 0;

  /* 
    Idea:
    We want to compute the product x * y iteratively, using only
    addition, doubling, and halving. 

    The algorithm is actually a variant of the 'Russian Peasant 
    Multiplication' method, which in turn is based on multiplication 
    via repeated addition. The difference is that here the process 
    is optimized by doubling and halving, which reduces the number 
    of iterations needed to compute the product.

    Repeated addition would mean starting from zero and adding the 
    same number once for each unit of the multiplier. After as many 
    additions as the multiplier’s value, the accumulated sum equals 
    the product. For large multipliers this is inefficient.

    The Russian peasant method speeds this up by repeatedly halving 
    the multiplier and doubling the amount that would be added in a 
    single step. Whenever the multiplier is odd, one copy of this 
    current amount is folded into the accumulated sum before the 
    multiplier is halved, and when the multiplier is even, we simply 
    halve it and double the amount without changing the sum. 
    As a result, we reconstruct the same product using far fewer 
    additions, in a way that is reminiscent of exponentiation by 
    squaring, but with addition playing the role that multiplication 
    has in the exponentiation algorithm.

    In order to prove correctness, we maintain the following
    invariant throughout the loop:
    
          z + a * b == x * y && b >= 0

    Where:
      • z is the accumulated sum that will eventually 
        hold the final product x * y
      • a is the current value that we will add to z 
        when b is odd. So, initially a = x
      • b is the counter indicating how many times we 
        still need to add a to z. So, initially b = y

    Thus, at all times, the first part of the invariant states that 
    the sum of the accumulated total z and the remaining product 
    a * b equals the original product x * y that we want to compute,
    while b >= 0 ensures that b can validly serve as a counter.

    Initially, we have:
      a = x, b = y, z = 0.
    From the precondition y >= 0 we get b >= 0.
    Also: z + a * b = 0 + x * y = x * y
    So the invariant holds at the start.

    The loop then proceeds as long as counter b > 0. In each 
    iteration, we do the following:

      • If b is odd, we perform:
          z := z + a;
          b := b - 1;

        Here we 'peel off' one copy of a, and add it to z, 
        thereby decreasing b by 1 and making b even. The
        invariant is preserved because:
          (z + a) + a * (b - 1)  =  z + a * b

      • Once b is even, we use that b = 2 * (b / 2), and rewrite
        a * b as (2 * a) * (b / 2). This allows us to replace:

            (a, b)  by  (2 * a, b / 2)

        without changing the product a * b, hence without changing
        z + a * b, and thus preserving the invariant. 

    To prove termination, we use b as the variant. By the second 
    invariant we always have b >= 0. In each iteration where b > 0,
    we show that b strictly decreases:

      • If b is odd, we first do b := b - 1, which makes b even 
        and smaller, then b := b / 2, which makes it smaller again 
        (or keeps it at 0). Overall, the final b at the end of the 
        iteration is strictly smaller than the b at the start.

      • If b is even, we skip the first branch and only perform
        b := b / 2. 
        Since b > 0 at loop entry, we have 0 <= b / 2 < b, 
        so b again strictly decreases.

    Hence b is a non-negative integer that strictly decreases on 
    every iteration while b > 0, so the loop terminates.
  */

  while b > 0
    invariant z + a * b == x * y
    invariant b >= 0
    decreases b
  {
    if b % 2 == 1 
    {
      /* b is odd: peel off one copy of a, making b even.
        The invariant is preserved because:
           z + a*b  ⇒  (z + a) + a*(b - 1)  =  z + a*b.
      */
      z := z + a;
      b := b - 1;
    }

    /* At this point b is even, so we can rewrite:
         a * b  =  a * (2 * (b / 2))  =  (2 * a) * (b / 2),
       and replace (a, b) by (2*a, b/2), preserving a*b
       and thus z + a*b.
       The assertions help Dafny to verify these facts.
    */

    assert b % 2 == 0;    
    assert z + a * b == z + a * (b / 2) * 2;
    
    b := b / 2;
    a := 2 * a;
  }

  /* 
    At loop exit we have: b <= 0

    Together with the invariant b >= 0, this implies: b == 0

    Using the main invariant, we obtain:

         z + a * b == x * y
      ⇒  z + a * 0 == x * y
      ⇒  z == x * y.

    This is exactly the postcondition.
  */
}
