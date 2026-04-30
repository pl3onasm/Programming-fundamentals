/* 
  file: prob2.c
  author: David De Potter
  description: 3-3rd exam 2025, problem 2,
    semiprime triplets
  Note on efficiency:
    This implementation uses trial division in isSemiprime.
    For large n, a more efficient approach would be to use a
    sieve to precompute the smallest prime factor for each
    number up to n, allowing for faster factorization.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Returns 1 iff n can be written as p*q where p and q are primes
// (not necessarily distinct). Returns 0 otherwise.
// Precondition: n >= 1
int isSemiprime(int n) {
  int count = 0, m = n;
    // check number of prime factors up to sqrt(n)
  for (int i = 2; i <= m / i; i += (i == 2) ? 1 : 2) {
    while (m % i == 0) {
      m /= i;
      if (++count > 1)
        return i * i == n;  // 1 if semiprime with equal primes
    }
  }

  return count == 1;        // 1 if semiprime with distinct primes
}

//===================================================================

int main(){
  int n, count = 0, i = 0, j = 0, k = 0;

  assert(scanf("%d", &n) == 1);

    // We maintain a rolling window of size 3 to efficiently check 
    // for semiprime triplets, so we start at a = 3 
    // and go up to n + 2
  for (int a = 3; a <= n + 2; ++a) {
    k = j;
    j = i;
    i = isSemiprime(a);

    if (i && j && k) 
        // (a-2, a-1, a) is a semiprime triplet
      ++count;
  } 

  printf("%d\n", count);
  return 0;
}

