/* file: prob5.c
   author: David De Potter
   description: IP mid2019, problem 5, primal sums
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
// Builds an array of all primes <= b. Returns the number of primes 
// found.
int buildPrimes(int *primes, int b) {
  int cnt = 0;
  for (int x = 2; x <= b; ++x)
    if (isPrime(x))
      primes[cnt++] = x;
  return cnt;
}

//=================================================================
// Checks if n can be expressed as a sum of at least two distinct, 
// consecutive primes less than n 
int isPrimalSum (int n, int *primes, int nPrimes) {
  for (int s = 0; s < nPrimes; ++s) {
    if (primes[s] >= n) break;
    int sum = primes[s];
    for (int t = s + 1; t < nPrimes; ++t) {
      sum += primes[t];
      if (sum == n) return 1;
      if (sum >  n) break;
    }
  }
  return 0;
}

//=================================================================

int main() {
  int a, b, count = 0, primes[2000];

  assert(scanf("%d %d", &a, &b) == 2);
  
  int nPrimes = buildPrimes(primes, b);

  for (int n = a; n <= b; ++n)
    if (isPrime(n) && isPrimalSum(n, primes, nPrimes))
      ++count;

  printf("%d\n", count);
  return 0;
}
