/* file: prob4.c
   author: David De Potter
   description: IP mid2022, problem 4, Cuban primes
   The trick is to just simplify the given expression, 
   using the fact that a³ - b³ = (a-b)(a² + ab + b²), 
   in the following way: 
   p = (q+1)³ - q³ = (q+1-q)((q+1)² + q*(q+1) + q²) 
   = 3*q² + 3*q + 1 = 3*q*(q+1) + 1
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Check if n is prime
int isPrime(int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================

int main() {
  int p; 
  assert(scanf("%d", &p) == 1);

    // A Cuban prime must be prime
  if (!isPrime(p)) {
    printf("NO\n");
    return 0;
  }

    // Check if there exists q such that p = 3*q*(q+1) + 1
  for (int q = 1; ; ++q) {
    int val = 3 * q * (q + 1) + 1;
    if (val > p) break;
    if (p == val) {
      printf("YES\n");
      return 0;
    }
  }

  printf("NO\n");
  return 0;
}