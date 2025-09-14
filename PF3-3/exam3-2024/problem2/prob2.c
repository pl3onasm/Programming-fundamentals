/* 
  file: prob2.c
  author: David De Potter
  description: PF 3/3rd term 2024, problem 2, lychrel
  note: the check for overflow in reverseInt is not 
    required to pass the test cases that are given,
    but should be included for a correct implementation
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int reverseInt (int n) {
  // reverses an integer n 
  // returns INT_MAX if the reverse overflows
  int rev = 0;
  while (n) {
    // check for overflow
    if (rev >= INT_MAX / 10 - n % 10)
      return INT_MAX;
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;   
}

int main(int argc, char *argv[]) {
  int n, rev;
  (void)! scanf("%d", &n);

  // keep adding the reverse of n to n until n is 
  // a palindrome or until the sum exceeds INT_MAX
  while ((rev = reverseInt(n)) != n) {
    if (rev >= INT_MAX - n) {
      printf("YES\n");
      return 0;
    }
    n += rev;
  }

  printf("NO\n");
  return 0;
}