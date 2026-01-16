/* 
  file: prob16.c
  author: David De Potter
  description: extra, problem 16, prime choice
  
  Approach:
    We use the mentioned upper bound for p_n and apply the Sieve 
    of Eratosthenes up to that limit, then we count primes until 
    reaching the n-th one.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include "../../Functions/include/clib/macros.h"

//=================================================================
// Returns a safe upper bound on the n-th prime number
// for n >= 6 (Rosser & Schoenfeld).
size_t getUpperBound(int n) {
  if (n < 6)
    return 15; 

  double ln = log((double) n);
  double ln2 = log(ln);
  return n * (ln + ln2) + 1;
}

//=================================================================
// Applies the Sieve of Eratosthenes up to 'limit', and finds the 
// n-th prime. Returns 0 if not found.
size_t findNthPrime(int n) {
  size_t limit = getUpperBound(n);

  char *isPrime;
  C_NEW_ARRAY_FILL(char, isPrime, limit, 1);

  isPrime[0] = 0; 
  isPrime[1] = 0;

  for (size_t i = 2; i <= limit / i; ++i) {
    if (isPrime[i]) {
      for (size_t j = i * i; j <= limit; j += i)
        isPrime[j] = 0;
    }
  }

  size_t count = 0;
  for (size_t i = 2; i <= limit; ++i) {
    if (isPrime[i]) {
      ++count;
      if (count == n) {
        free(isPrime);
        return i;
      }
    }
  }

  free(isPrime);
  return 0;
}

//=================================================================

int main() {
  int n;
  assert(scanf("%d", &n) == 1);

  size_t result = findNthPrime(n);

  printf("%zu\n", result);

  return 0;
}
