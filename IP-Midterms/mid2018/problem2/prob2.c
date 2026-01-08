/* file: prob2.c
   author: David De Potter
   description: problem 2, double palindromes, mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if n is a palindrome in given base
int isPalindrome(int n, int base) {
  if (n == 0) return 1;
  int rev = 0, m = n;
  while (m) {
    rev = rev * base + m % base;
    m /= base;
  }
  return rev == n;
}

//=================================================================

int main() {
  int a, b, count = 0; 
  assert(scanf("%d %d", &a, &b) == 2);
  
  for (int n = a; n <= b; ++n) 
    if (isPalindrome(n, 2) && isPalindrome(n, 10)) 
      ++count;

  printf("%d\n", count);
  return 0;
}