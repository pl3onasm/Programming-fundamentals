/* file: prob4.c
   author: David De Potter
   description: IP mid2019 resit, problem 4,
   palindromic prime product numbers
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
// Checks if the integer n is a palindrome
int isPalindrome(int n) {
  int rev = 0, m = n;
  while (m > 0) {
    rev = rev * 10 + m % 10;
    m /= 10;
  }
  return rev == n;
}

//=================================================================
// Checks if n has two distinct proper prime divisors. The loop
// uses d * d < n to ensure distinctness (ignores square roots).
int hasTwoPrimeDivs (int n) {
  for (int d = 2; d < n / d; ++d)
    if (n % d == 0 && isPrime(d) && isPrime(n / d))
      return 1;
  return 0;
}

//=================================================================

int main() {
  int n, a, b, count = 0;
  assert(scanf("%d %d", &a, &b) == 2);
  for (n = a; n <= b; ++n) 
    if (isPalindrome(n) && hasTwoPrimeDivs(n))
      ++count;
  printf("%d\n", count);
  return 0;
}
