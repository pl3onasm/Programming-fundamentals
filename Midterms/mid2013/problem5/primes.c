/* file: primes.c
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

int power(int num, int exp) {
  /* returns number^exponent */
  int m=1;
  while (exp!=0) {
    if (exp%2 == 0) {
      num *= num; exp /= 2;
    } else {
      m *= num; exp--;
    }
  }
  return m;
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
  //returns the left rotation of a given number
  int firstDigit, rotation = 0;
  firstDigit = x/power(10, length-1);
  rotation = (x%power(10, length-1))*10 + firstDigit;
  return rotation;
}

int main(int argc, char *argv[]) {
  int a, b, length, valid, n, rot;

  scanf ("%d %d", &a, &b);
  for (n = a; n <= b; ++n) {
    length = countDigits(n);
    if (length <= 1) {
      if (isPrime(n)) printf("%d\n", n);
      continue;
    } else { // length n >= 2
      if (hasDivisibleDigits(n)) continue;
      /* if in this case any of n's digits is divisible by 2 or 5,
       * this means that at least one of its rotations will not be a prime,
       * and n can never be a super prime, so we jump to the next n */
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