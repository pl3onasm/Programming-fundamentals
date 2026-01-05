/* file: prob3.c
   author: David De Potter
   description: IP mid2022, problem 3, perfect product

   Approach:
   A number is a perfect square iff in its prime factorization all
   exponents are even. So we factor a, and for every prime p that
   occurs an odd number of times in a, we multiply b by p once.
   Then a*b has only even exponents, and is thus a perfect square.
   This also means that if the input number a is a prime number,
   then b = a, since a occurs once (odd) in its own factorization.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int a;
  assert(scanf("%d", &a) == 1);

  int x = a;
  int b = 1;

  for (int p = 2; p <= x / p; p += (p == 2 ? 1 : 2)) {
    int odd = 0;
    while (x % p == 0) {
      x /= p;
      odd ^= 1;    // flip parity of exponent
    }
    if (odd)
      b *= p;
  }

  if (x > 1)       // leftover prime factor > sqrt(a)
    b *= x;

  printf("%d\n", b);
  return 0;
}