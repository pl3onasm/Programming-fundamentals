/* file: prob2.c
   author: David De Potter
   description: IP mid2021 resit, problem 2, nested palindromes
*/

#include <stdio.h>
#include <stdlib.h>

int isPalindrome(int n) {
  int rev = 0, m = n;
  while (m > 0) {
    rev = rev * 10 + m % 10;
    m /= 10;
  }
  return rev == n;
}

int containsZero(int n) {
  while (n > 0) {
    if (n % 10 == 0) return 1;
    n /= 10;
  }
  return 0;
}

int nested(int n) {
  int m=0, factor = 1;
  while (n >= 10) {
    m += factor * (n % 10); 
    factor *= 10;
    n /= 10;
    if (isPalindrome(m) && isPalindrome(n)) return 1; 
  }
  return 0;
}

int main(int argc, char *argv[]) {
  int n; 
  scanf("%d", &n);
  if (isPalindrome(n)) {
    if (containsZero(n) || !nested(n)) printf("PALINDROME\n");
    else printf("NESTED\n");
  } else printf("NONE\n");
  return 0;
}