/* 
  file: prob2.c
  author: David De Potter
  description: PF 3/3rd term 2024, problem 2, lychrel
  note: the check for overflow is not required to pass 
    the test cases that are given, but should be included 
    for a correct implementation
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <assert.h>

//=================================================================
// Reverses the digits of n and returns the reversed number
// If the reversed number exceeds INT_MAX, returns -1
int reverseInt(int n) {
  long long rev = 0;
  while (n) {
    rev = rev * 10 + (n % 10);
    n /= 10;
  }
  if (rev > INT_MAX) return -1;
  return (int) rev;
}

//=================================================================

int main() {
  int n, rev;
  assert(scanf("%d", &n) == 1);

  // keep adding the reverse of n to n until n is 
  // a palindrome or until the sum exceeds INT_MAX
  while ((rev = reverseInt(n)) != n) {
    if (rev == -1 || rev > INT_MAX - n) {
      printf("YES\n");
      return 0;
    }
    n += rev;
  }

  printf("NO\n");
  return 0;
}