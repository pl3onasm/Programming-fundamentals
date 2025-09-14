/* file: prob2.c
* author: David De Potter
* description: problem 2, double palindromes, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int isPalindrome(int n, int base) {
  // check if n is a palindrome in given base
  int rev = 0, m = n;
  while (m) {
    rev = rev * base + m % base;
    m /= base;
  }
  return rev == n;
}

int main(int argc, char *argv[]) {
  int a, b, count = 0; 
  (void)! scanf("%d %d", &a, &b);
  
  for (int n = a; n <= b; ++n) {
    if (isPalindrome(n,2) && isPalindrome(n,10)) 
      count++;
  }

  printf("%d\n", count);
  return 0;
}