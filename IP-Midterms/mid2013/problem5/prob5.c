/* file: prob5.c
* author: David De Potter
* description: problem 5, circular primes, mid2013
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks whether given number is prime
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

int hasDivisibleDigits (int n) {
  //checks if any of number's digits is divisible by 2 or 5
  while (n != 0) {
    int digit = n % 10;
    if (digit % 2 == 0 || digit % 5 == 0) return 1;
    n /= 10;
  }
  return 0;
}

int countDigits (int n) {
  //returns length of given number
  int count=0;
  while (n != 0) {
    count++; n /= 10;
  }
  return count;
}

int leftRotate (int x, int length) {
  /* returns the left rotation of a given number x,
     ignoring leading zeros, e.g. 1234 -> 2341 */
  int pow = power(10, length-1);
  int firstDigit = x / pow;
  return (x % pow)*10 + firstDigit;
}

int main(int argc, char *argv[]) {
  int a, b, length, valid, n, rot;
  (void)! scanf ("%d %d", &a, &b);

  for (n = a; n <= b; ++n) {
    length = countDigits(n);
    if (length <= 1 && isPrime(n)) printf("%d\n", n);
    else { 
      if (hasDivisibleDigits(n)) continue;
      /* if any of n's digits is divisible by 2 or 5, then at 
       * least one of its rotations will not be a prime, and n can
       * never be a circular prime, so we jump to the next n */
      valid = 1; rot = n;
      for (int i = 0; i < length; ++i) {
        // checks if all rotations, including n itself, are prime
        if (!(isPrime(rot))) {
          valid = 0;
          break;
        }
        rot = leftRotate(rot, length);
      }
      if (valid) printf("%d\n", n);
    }
  }

  return 0;
}