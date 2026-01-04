/* file: prob5-2.c
   author: David De Potter
   version: 5.2, using an int function
   description: IP Final 2018 Resit, problem 5,
     minimal palindromic partition
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <assert.h>

//=================================================================
// Checks whether the substring s[start..end] is a palindrome
int isPalindrome(char *s, int start, int end) {
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(s, start + 1, end - 1);
}

//=================================================================
// Computes the minimal number of palindromic partitions
// of the string a[start..end]
int minimalPalPartition(int start, int end, char *a) {
  int x, min = INT_MAX;
  if (start > end) return 0;
  for (int j = start; j <= end; ++j) {
    if (isPalindrome(a, start, j)) {
      x = 1 + minimalPalPartition(j + 1, end, a);
      min = x < min ? x : min;
    }
  }
  return min;
}

//=================================================================

int main() {
  char a[21];
  assert(scanf("%s", a) == 1);

  printf("%d\n", minimalPalPartition(0, strlen(a) - 1, a));

  return 0;
}
 