/* file: palindromic.c
* author: David De Potter
* description: IP mid2019 resit, problem 4,
* palindromic prime product numbers
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  /* checks whether x is prime or not */
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int isPalindrome(int n) {
  int rev = 0, m = n;
  while (m > 0) {
    rev = rev * 10 + m % 10;
    m /= 10;
  }
  return rev == n;
}

int hasTwoPrimeDivs (int n) {
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
  for (n = a; n <= b; ++n) 
    if (isPalindrome(n) && hasTwoPrimeDivs(n))
      count++;
  printf("%d\n", count);
  return 0;
}
