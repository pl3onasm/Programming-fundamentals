/* file: prob3.c
   author: David De Potter
   description: problem 3, mother of all primes, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if n is prime
int isPrime(int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================
// Determines number of k-descendants for a given prime p. As each
// prime is its own 1-descendant, desc = 1 is the default return 
// value
int k_descendants (int p) {
  int desc = 1, n;

  for (int k = 2; k <= 6; ++k) {
      // it is given that a <= p <= b <= 1000000, 
      // so the number of k-descendants cannot exceed 6
    n = p * k + k - 1;
    if (isPrime(n)) ++desc;
    else break;
  }
  
  return desc;
}

//=================================================================

int main() {
  int a, b, p, k, n = 0, max = 0;

  assert(scanf ("%d %d", &a, &b) == 2);

  for (p = a; p <= b; ++p) {
    if (isPrime(p)) {
      k = k_descendants(p);
      if (k > max) {
        // strictly greater than, because the smallest
        // solution needs to be printed in case of ties
        max = k;
        n = p;
      }
    }
  }

  printf (max ? "%d %d\n" : "NONE\n", n, max);
  
  return 0;
}
