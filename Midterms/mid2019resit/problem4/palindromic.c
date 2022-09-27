/* file: palindromic.c
* author: David De Potter
* description: IP mid2019 resit, problem 4,
* palindromic prime product numbers
*
* A prime is an integer greater than 1 that has no
* positive divisors other than 1 and itself. The first
* 20 primes are:
* 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71
*
* A palindromic number is a number that remains the same
* when its digits are reversed. An example of a palindromic
* number is 1234321.
*
* We call a palindromic number a palindromic prime product
* number if it is the product of two distinct primes.
* For example, the number 9163619 is a palindromic number,
* and it is the product of the primes 157 and 58367.
* Hence, 9163619 is a palindromic prime product number.
* The palindromic number 121 is not a palindromic product
* prime number since it is not the product of two distinct
* primes (121 = 11x11).
*
* Write a program that reads from the input two positive
* integers a and b (where 1 <= a <= b <= 10000), and
* outputs the number of palindromic product numbers n
* with a <= n <= b .
*/

#include <stdio.h>
#include <stdlib.h>

int power(int n, int exp) {
  /* returns n^exp */
  int m=1;

  while (exp!=0) {
    if (exp % 2 == 0) {
      n *= n;
      exp = exp/2;
    } else {
      m *= n;
      exp--;
    }
  }
  return m;
}

int isPrime (int x) {
  /* checks whether x is prime or not */

  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int countDigits(int n) {
  /* returns length of integer n */
  int count=0;

  while (n != 0) {
    count++;
    n /= 10;
  }
  return count;
}

int isDecPalindrome (int n, int len) {
  /* Determines if a decimal number is palindromic */
  int exp = len-1;
  for (int i=0; i < len/2; ++i) {
    int p = power(10, exp);
    if (n % 10 != n/p) return 0;
    n = n % p;
    n /= 10;
    exp -= 2;
  }
  return 1;
}

int hasTwoDistinctPrimeDivisors (int n) {
  /* checks if n has two distinct proper divisors
   * which are both prime */

  for (int d = 2; d * d < n; ++d)
    /* uses strictly less than so as to ignore
     * square roots and enforce distinctness */
    if (n % d == 0)
      if (isPrime(d) && isPrime(n / d))
        return 1;
  return 0;
}

int main(int argc, char *argv[]) {
  int n, a, b, count=0;

  scanf("%d %d", &a, &b);

  for (n = a; n <= b; ++n) {
    int len = countDigits(n);
    if (isDecPalindrome(n, len)
      && hasTwoDistinctPrimeDivisors(n))
        count++;
    }

  printf("%d\n", count);
  return 0;
}
