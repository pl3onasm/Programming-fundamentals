/* file: prob4-2.c
   author: David De Potter
   description: problem 4, PDS numbers, resit mid2018
   version: 4.2, using Sieve of Eratosthenes, which speeds
            up the primality tests
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MAXN 1000000

//=================================================================
// Allocates memory, and checks whether this was successful
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Sieve of Eratosthenes: prime[n] = 1 iff n is prime (0..MAXN)
void sieve(char *isPrime) {
  for (int i = 0; i <= MAXN; ++i) isPrime[i] = 1;
  isPrime[0] = 0;
  isPrime[1] = 0;

  for (int p = 2; p * p <= MAXN; ++p)
    if (isPrime[p])
      for (int k = p * p; k <= MAXN; k += p)
        isPrime[k] = 0;
}

//=================================================================
// Replaces each digit d of p with the remainder of division
// of d^2 by 10
int replaceDigits(int p) {
  int result = 0, pow10 = 1;
  while (p) {
    int d = p % 10;
    int sqdigit = d * d;
    result += (sqdigit % 10) * pow10;
    pow10 *= 10;
    p /= 10;
  }
  return result;
}

//=================================================================
// Checks if n is a Primal Digit Square number
int isPDS(int n, char *isPrime) {
  int next;
  while (isPrime[n]) {
    next = replaceDigits(n);
    if (n == next) return 1;
    n = next;
  }
  return 0;  // at least one non-prime number encountered 
}

//=================================================================

int main(void) {
  int a, b, count = 0;

  assert(scanf("%d %d", &a, &b) == 2);

  char *isPrime = safeMalloc((MAXN + 1) * sizeof(char));

  sieve(isPrime);

  for (int n = a; n <= b; ++n)
    if (isPDS(n, isPrime)) ++count;

  printf("%d\n", count);

  free(isPrime);
  return 0;
}