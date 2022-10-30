/* file: prob4.c
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

int power(int n, int exp) {
  /* returns n^exp using exponentiation by squaring, 
     aka binary exponentiation */
  int m=1;
  while (exp != 0) {
    if (exp%2 == 0) {
      n *= n; exp /= 2;
    } else {
      m *= n; exp--;
    }
  }
  return m;
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
  if (isPrime(n) && isPrime(getInnerNumber(n))) printf("YES\n");
  else printf("NO\n");
  return 0;
}
