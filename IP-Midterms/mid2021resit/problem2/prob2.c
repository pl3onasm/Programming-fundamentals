/* file: prob2.c
   author: David De Potter
   description: IP mid2021 resit, problem 2, nested palindromes
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Check if the integer n is a palindrome
int isPalindrome(int n) {
  int rev = 0, m = n;
  while (m > 0) {
    rev = rev * 10 + m % 10;
    m /= 10;
  }
  return rev == n;
}

//=================================================================
// Check if the integer n contains the digit 0  
int containsZero(int n) {
  while (n > 0) {
    if (n % 10 == 0) return 1;
    n /= 10;
  }
  return 0;
}

//=================================================================
// Check if n is a nested palindrome
int isNested(int n) {
  int m = 0, factor = 1;
  while (n >= 10) {
    m += factor * (n % 10); 
    factor *= 10;
    n /= 10;
    if (isPalindrome(m) && isPalindrome(n)) 
      return 1; 
  }
  return 0;
}

//=================================================================

int main() {
  int n; 
  assert(scanf("%d", &n) == 1);

  if (isPalindrome(n)) {
    if (containsZero(n) || ! isNested(n)) 
      printf("PALINDROME\n");
    else printf("NESTED\n");
  } else printf("NONE\n");
  
  return 0;
}