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
  // returns n^exp using binary exponentiation
  int pow = 1;
  while (exp) {
    if (exp & 1) {
      pow *= n;
      --exp;
    }  
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

int countDigits (int p) {
  //counts the number of digits of p
  int count = 0;
  while (p != 0) {
    count++; 
    p /= 10;
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
  (void)! scanf ("%d", &n);

  if (isPrime(n) && isPrime(getInnerNumber(n))) printf("YES\n");
  else printf("NO\n");
  
  return 0;
}
