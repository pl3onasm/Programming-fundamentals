/* file: prob3.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 3, circular primes
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks whether n is prime
int isPrime (int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================
// Checks the digits of n: if any digit is even or 5,
// returns 0. Otherwise returns the number of digits in n
int checkDigits (int n) {
  int count = 0, d;
  while (n > 0) {
    d = n % 10;
    if (d % 2 == 0 || d == 5) return 0; 
    n /= 10;
    count++;
  }
  return count;
}

//=================================================================
// Checks whether n is a circular prime with d digits
int isCircularPrime (int n, int d) {
  int power10 = 1;
  for (int i = 1; i < d; ++i)
    power10 *= 10;
  for (int i = 0; i < d; ++i) {
    if (!isPrime(n)) return 0;
    n = (n % 10) * power10 + n / 10;
  }
  return 1;
}

//=================================================================

int main() {
  int n, d;
  assert(scanf ("%d", &n) == 1);

    // single-digit circular primes: 2,3,5,7
  if (n == 2 || n == 3 || n == 5 || n == 7) {
    printf("YES\n");
    return 0;
  }

    // check if n is a circular prime
  if ((d = checkDigits(n)) && isCircularPrime(n, d)) 
    printf("YES\n");
  else
    printf("NO\n");

  return 0;
}