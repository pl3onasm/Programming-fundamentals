/* file: prob4-1.c
   author: David De Potter
   description: problem 4, PDS numbers, resit mid2018
   version: 4.1, using primality test with trial division
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
// Replaces each digit d of p with the remainder of division 
// of d^2 by 10
int replaceDigits (int p) {
  int result = 0, pow10 = 1;
  while (p) {
    int sqdigit = (p % 10) * (p % 10);
    result += (sqdigit % 10) * pow10;
    pow10 *= 10;
    p /= 10;
  }
  return result;
}

//=================================================================
// Checks if n is a Primal Digit Square number
int isPDS (int n) {
  int new;
  while (isPrime(n)) {
    new = replaceDigits(n);
    if (n == new) return 1;
    n = new;
  }
  return 0;  // at least one non-prime number encountered
}

//=================================================================

int main () {
  int a, b, count = 0;

  assert(scanf ("%d %d", &a, &b) == 2);

  for (int n = a; n <= b; ++n) 
    if (isPDS(n)) ++count;
     
  printf("%d\n", count);
  return 0;
}
