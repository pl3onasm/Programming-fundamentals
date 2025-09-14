/* file: prob3.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 3, circular primes
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  /* checks whether x is prime */
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) {
    if (x % i == 0) return 0;
  }
  return 1;
}

int power(int n, int exp) {
  // returns n^exp using binary exponentiation
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

int checkDigits (int n) {
  /* returns 0 if n contains digits 2, 4, 6, 8 or 5,
     otherwise returns the number of digits in n */
  int count = 0, d;
  while (n > 0) {
    d = n % 10;
    if (d % 2 == 0 || d == 5) return 0; 
    n /= 10;
    count++;
  }
  return count;
}

int isCircularPrime (int n, int d) {
  /* returns 1 if n is a circular prime, 0 otherwise */
  for (int i = 0; i < d; i++) {
    if (!isPrime(n)) return 0;
    n = (n % 10) * power(10, d-1) + n / 10;
  }
  return 1;
}

int main(int argc, char *argv[]) {
  int n, d;
  (void)! scanf ("%d", &n);

  // special cases for single digit numbers
  if (n == 2 || n == 5 || n == 7) {
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