/* file: prob4.c
   author: David De Potter
   description: extra, problem 4, binary palindromes
*/

#include <stdio.h>
#include <stdlib.h>

int isPalindrome(int n) {
  // checks if n is a binary palindrome with
  // odd number of 1s
  int rev = 0, orig = n, sum = 0;
  while (orig) {
    rev = (rev << 1) | (orig & 1);
    orig >>= 1;
    sum += rev & 1;
  }
  return rev == n && sum % 2;
}

void printBinary(int n) {
  // prints the binary representation of n
  while (n) {
    printf("%d", n & 1);
    n >>= 1;
  }
}

void generatePalindromes(int a, int b) {
  // generates all binary palindromes in [a, b] 
  // having odd number of 1s
  int found = 0;
  for (int i = a; i <= b; ++i)
    if (isPalindrome(i)) {
      found = 1;
      printf("%d: ", i); 
      printBinary(i);
      printf("\n");
    }
  if (!found)
    printf("0\n");
}

int main() {
  int a, b;
  (void)! scanf("%d %d", &a, &b);

  generatePalindromes(a, b);
  
  return 0;
}