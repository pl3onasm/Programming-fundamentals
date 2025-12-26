/* file: prob4.c
   author: David De Potter
   description: extra, problem 4, binary palindromes
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if n is a binary palindrome with odd number of 1s
int isPalindrome(size_t n) {
  size_t rev = 0, orig = n, sum = 0;
  while (orig) {
    rev = (rev << 1) | (orig & 1);
    orig >>= 1;
    sum += rev & 1;
  }
  return rev == n && sum % 2;
}

//=================================================================
// Prints the binary representation of n
void printBinary(size_t n) {
  while (n) {
    printf("%zu", n & 1);
    n >>= 1;
  }
}

//=================================================================
// Generates all binary palindromes in [a, b] having odd 
// number of 1s
void generatePalindromes(size_t a, size_t b) {
  int found = 0;
  for (size_t i = a; i <= b; ++i)
    if (isPalindrome(i)) {
      found = 1;
      printf("%zu: ", i); 
      printBinary(i);
      printf("\n");
    }
  if (!found)
    printf("0\n");
}

//=================================================================

int main() {
  size_t a, b;
  assert(scanf("%zu %zu", &a, &b) == 2);

  generatePalindromes(a, b);
  
  return 0;
}