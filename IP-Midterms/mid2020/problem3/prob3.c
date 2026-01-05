/* file: prob3.c
  author: David De Potter
  description: IP mid2020, problem 3, prime gaps
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
  int n, p = 2, q = 3;
  assert(scanf("%d", &n) == 1);

  while (q - p < n) {
    p = q; 
    do ++q; 
    while (! isPrime(q));
  }

  printf("%d-%d=%d\n", q, p, q - p);
  return 0;
}