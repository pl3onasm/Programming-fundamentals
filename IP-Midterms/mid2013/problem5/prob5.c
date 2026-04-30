/* file: prob5.c
   author: David De Potter
   description: problem 5, circular primes, mid2013
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
// Checks if any of n's digits is divisible by 2 or 5
int hasDivisibleDigits (int n) {
  while (n != 0) {
    int digit = n % 10;
    if (digit % 2 == 0 || digit % 5 == 0) return 1;
    n /= 10;
  }
  return 0;
}

//=================================================================
// Counts the number of digits of n
  int countDigits (int n) {
  int count = 0;
  do {
    ++count;
    n /= 10;
  } while (n);
  return count;
}

//=================================================================
// Returns the left rotation of x with given length, ignoring 
// leading zeros, e.g. 1234 -> 2341
int leftRotate (int x, int length) {
  int pow = 1;
  for (int i = 1; i < length; ++i) 
    pow *= 10;
  int firstDigit = x / pow;
  return (x % pow) * 10 + firstDigit;
}

//=================================================================

int main() {
  int a, b, length, valid, n, rot;
  assert(scanf ("%d %d", &a, &b) == 2);

  for (n = a; n <= b; ++n) {
    length = countDigits(n);
    if (length <= 1 && isPrime(n)) 
      printf("%d\n", n);
    else { 
      if (hasDivisibleDigits(n)) 
        // if any of n's digits is divisible by 2 or 5, then at 
        // least one of its rotations is not prime, so we skip n
        continue;

        // check if all rotations, including n itself, are prime
      valid = 1; rot = n;
      for (int i = 0; i < length; ++i) {
        if (! isPrime(rot)) {
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