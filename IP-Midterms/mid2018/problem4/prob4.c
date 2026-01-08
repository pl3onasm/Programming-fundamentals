/* file: prob4.c
   author: David De Potter
   description: problem 4, primal primes, mid2018
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

int main() {
  int n, index = 0, x, primalPrimes = 0;

  assert(scanf ("%d", &n) == 1);
  
  for (x = 2; ; ++x) {
    if (isPrime(x)) {
      ++index;
      if (isPrime(index)) {
        ++primalPrimes;
        if (primalPrimes == n) 
          break;
      }
    }
  }

  printf("%d\n", x);

  return 0;
}
