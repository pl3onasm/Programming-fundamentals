/* file: prob1.c
   author: David De Potter
   description: extra, problem 1, sum of multiples

   Explanation:
    The sum of all natural numbers from 1 to n is given by the
    formula n*(n+1)/2.

    We are given positive integers a, b, and n, and we want the sum
    of all multiples of a or b that are strictly below n.
    Therefore, we first replace n by n - 1, so that "below the 
    original n" becomes "up to the new n" (inclusive).

    Let's take for example a = 5 and b = 7.
    Observe that the sum of all multiples of 5 up to n is given by
        5+10+15+...+5*(n/5) 
      = 5*(1+2+3+...+n/5) 
      = 5*(n/5)*(n/5+1)/2
    Similarly, the sum of all multiples of 7 up to n is given by
      7*(n/7)*(n/7+1)/2
    
    However, if we add these two sums, we will have counted
    the numbers divisible by both 5 and 7 twice. We can correct 
    this by subtracting the sum of the multiples of the least
    common multiple of 5 and 7, which is 35. This sum is given
    by 35*(n/35)*(n/35+1)/2

    In general, the sum of all multiples of a and b up to
    n is given by the formula:
        a*(n/a)*(n/a+1)/2 
      + b*(n/b)*(n/b+1)/2 
      - lcm*(n/lcm)*(n/lcm+1)/2
    where lcm is the least common multiple of a and b.

    The practice of correcting for double counting when computing
    the size of the union of two sets is called the inclusion-
    exclusion principle. It can be formulated as follows:
    |A ⋃ B| = |A| + |B| - |A ⋂ B|
    where |A| denotes the cardinality of A, i.e. the number of
    elements in A. 

    Note on integer sizes:
    The problem statement mentions values can become very large. 
    Even if the final answer fits in an unsigned 64-bit integer 
    (unsigned long long), intermediate computations may overflow 
    64-bit. Therefore we use an unsigned 128-bit integer (u128) as 
    an internal computation buffer to keep these intermediate 
    products safe. At the end we print the u128 result with a 
    custom print function.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned long long int llu;

#if defined(__SIZEOF_INT128__)
  typedef __uint128_t u128;   
#else
  #error "128-bit integers not supported by this compiler"
#endif

//=================================================================
// Computes the greatest common divisor of a and b
llu GCD (llu a, llu b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

//=================================================================
// Computes the least common multiple of a and b
llu LCM (llu a, llu b) {
  return a / GCD(a, b) * b;
}

//=================================================================
// Computes the triangular number T(n) = 1+2+ ... +n = n*(n+1)/2
// in 128-bit to avoid overflow in intermediate products.
u128 addInts(llu n) {
  return ((u128)n * (n + 1)) / 2;
}

//=================================================================
// Prints an unsigned 128-bit integer
void printU128(u128 n) {
  if (n == 0) {
    printf("0\n");
    return;
  }

  char buffer[40];
  size_t index = 0;

  while (n) {
    buffer[index++] = (n % 10) + '0';
    n /= 10;
  }

  while (index--) putchar(buffer[index]);
  putchar('\n');
}

//=================================================================

int main() {
  llu a, b, n;

  assert(scanf("%llu %llu %llu", &a, &b, &n) == 3);

  --n;  // replace original n by n - 1 so that "below original n"
        // becomes "up to n" (inclusive) for the computations below

  llu lcm = LCM(a, b);

  u128 result = (u128)a   * addInts(n / a)
              + (u128)b   * addInts(n / b)
              - (u128)lcm * addInts(n / lcm);

  printU128(result);

  return 0;
}