/* file: prob4b.c
   author: David De Potter
   description: IP Final 2014, problem 4b, Iterative algorithms,
   Goldbach conjecture
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Checks if n is prime
int isPrime (int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================

int main() {
  int n;

  for (n = 3; ; n += 2) {
    if (!isPrime(n)) {
      int found = 0;

      for (int s = 1; 2 * s * s < n; ++s) {
        if (isPrime(n - 2 * s * s)) {
          found = 1;
          break;
        }
      }

      if (!found)
        break;
    }
  }

  printf("%d\n", n);
  return 0;
}