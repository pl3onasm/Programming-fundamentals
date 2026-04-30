/* 
  file: sol5Annotated.dfy
  author: David De Potter
  description: 3-3rd resit 2025, solution to problem 5,
               with annotations
*/

method mod3(x: nat) returns (m: nat)
  ensures m == x % 3
{
  var n : nat;
  n := x;
  m := 0;

  /*
    Idea:
    We want to compute x % 3 (the remainder modulo 3), without 
    using any direct division by 3 on the original number.

    For this, we use the following property for decimal numbers:

        x = 10 * (x / 10) + (x % 10)

    where:
      • x / 10  removes the last decimal digit
      • x % 10  is the last decimal digit

    Now we use the observation made in the problem statement 
    that 10 ≡ 1 (mod 3), since 10 = 3 * 3 + 1. This means that 
    multiplying by 10 does not change the remainder modulo 3.
    Therefore, we have:

        x ≡ (x / 10) + (x % 10)         (mod 3)
    
    The above means that the LHS and RHS have the same remainder
    when divided by 3: they are congruent modulo 3.
    Repeating this argument again and again, we obtain:

        x % 3 == (sum of decimal digits of x) % 3

    Hence we can compute x % 3 by scanning the digits of x from 
    right to left, and accumulating their sum modulo 3. This is
    exactly what the given program does.

    In order to prove correctness, we maintain the invariant:

        m < 3  &&  (m + n) % 3 == x % 3

    What this invariant states is:
      • m is always a valid remainder modulo 3 (0, 1, or 2), 
        i.e., the sum of the digits processed so far modulo 3
      • the sum of the processed digit sum modulo 3 (stored in 
        m) and the remaining number n (containing the digits yet 
        to be processed) has the same remainder modulo 3 as the 
        original number x.

    Initially, we set: n = x and m = 0, so the invariant holds 
    at the start:  m < 3  and  (0 + x) % 3 == x % 3.

    The loop continues as long as n > 0, i.e., as long as there
    are still digits left to process in n.
    In each loop iteration, we then do the following:
      • We take the last digit d = n % 10.
      • We add it into the running sum modulo 3:
            m = (m + d) % 3
      • We remove the last digit:
            n = n / 10

    The invariant is preserved in each iteration, as shown in the
    comments inside the loop.

    To prove termination, we use n as the variant. Since n is a
    natural number, we have n >= 0 at all times. In each iteration
    where n > 0, we do n = n / 10, which strictly decreases n 
    until it eventually reaches 0.
    From this we conclude that the loop must eventually terminate.
    Note that we do not need to explicitly specify the variant 
    here, as Dafny can automatically infer it.
  */

  while (n > 0)
    invariant m < 3 && (m + n) % 3 == x % 3
  {
    /*
      Let d = n % 10 be the last digit of n.

      We update m and n as follows:
        m' = (m + d) % 3
        n' = n / 10

      So we have:  m' ≡ m + d  (mod 3)
      And because 10 ≡ 1 (mod 3), we also have:
        n = 10 * (n / 10) + d
          ≡ (n / 10) + d       (mod 3)

      Therefore:
      m + n ≡ m + (n' + d)        (mod 3)
            ≡ (m + d) + n'        (mod 3)
            ≡ m' + n'             (mod 3)

      Hence: (m + n) % 3 == (m' + n') % 3.

      Also, m' = (m + d) % 3 is clearly less than 3.
      Thus, the invariant holds for the updated values m', n'.
    */

    m := (m + n % 10) % 3;
    n := n / 10;
  }

  /*
    At loop exit we have n <= 0. Since n is a nat, 
    this implies n == 0.
    Using the second conjunct of the invariant at this point, 
    we get:  (m + 0) % 3 == x % 3
              m % 3 == x % 3

    The first conjunct of the invariant says that m < 3, so m 
    is already a valid remainder modulo 3: m == m % 3.

    Hence: m == x % 3, which is exactly the postcondition.
  */
}
