/* file: primes.c
* author: David De Potter
* description: problem 4, encapsulating primes, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks if x is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int power (int x, int y) {
  //returns x to the power y
  int power = 1;
  if (y == 0) return 1;
  for (int i = 1; i<=y; ++i) power *= x;
  return power;
}

int countDigits (int p) {
  //counts the number of digits of p
  int count = 0;
  while (p != 0) {
    count++; p /= 10;
  }
  return count;
}

int getInnerNumber (int x) {
  /* gets the encapsulated number by removing the
   * first and last digit of x */
  int length = countDigits(x);
  return (x % power(10, (length-1))) /10;
}

int main(int argc, char *argv[]) {
  int n;
  scanf ("%d", &n);
  if (isPrime(n)) {
    if (isPrime(getInnerNumber(n))) printf("YES\n");
    else printf("NO\n");
    /* inner number is not a prime, so the input number
     * is not an encapsulating prime */
  } else printf("NO\n");
    /* the input number itself is not a prime, so it
     * can never be an encapsulating prime */
  return 0;
}
