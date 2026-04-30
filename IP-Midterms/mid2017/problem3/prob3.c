/* file: prob3.c
   author: David De Potter
   description: problem 3, highest common prime factor, mid2017
*/

#include <stdio.h>
#include <assert.h>

//=================================================================
// Computes the greatest common divisor of a and b
int GCD (int a, int b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

//=================================================================
// Computes the largest prime factor of n using trial division
int largestPrimeFactor(int n) {
  int largest = 1;

  while ((n & 1) == 0) {
    largest = 2;
    n /= 2;
  }

  for (int p = 3; p <= n / p; p += 2) {
    while (n % p == 0) {
      largest = p;
      n /= p;
    }
  }

  if (n > 1)
    largest = n;

  return largest;
}

//=================================================================

int main(void) {
  int a, b;

  assert(scanf("%d %d", &a, &b) == 2);

  int g = GCD(a, b);
  
  if (g == 1)
    printf("1\n");
  else
    printf("%d\n", largestPrimeFactor(g));

  return 0;
}
