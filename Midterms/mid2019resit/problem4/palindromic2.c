/* file: palindromic.c
* version: 2.0 (in this version the function
* isDecPalindrome is rewritten as a recursive function)
* author: David De Potter
* description: IP mid2019 resit, problem 4,
* palindromic prime product numbers
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

  if (len == 0 || len == 1) return 1;
  int p = power(10, len-1);
  if (n%10 != n/p) return 0;
  return isDecPalindrome ((n%p)/10, len-2);
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
