/* file: prob5-1.c
   author: David De Potter
   version: 5.1, using a void function
   description: IP Final 2018 Resit, problem 5,
   minimal palindromic partition
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#define MIN(a,b) ((a) < (b) ? (a) : (b))

int isPalindrome(char *s, int start, int end) {
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(s, start + 1, end - 1);
}

void makePartitions(int left, int right, char *a, int *min, int count) {
  if (left > right) {
    *min = MIN(*min, count);
    return;
  }
  for (int j = left; j <= right; j++) 
    if (isPalindrome(a, left, j)) 
      makePartitions(j + 1, right, a, min, count + 1);
}

int minimalPalPartition(int left, int right, char *a) {
  int min = INT_MAX;
  makePartitions (left, right, a, &min, 0);
  return min;
}

int main(int argc, char *argv[]) {
  char a[21];
  (void)! scanf("%s", a);
  printf("%d\n", minimalPalPartition(0, strlen(a) - 1, a));
  return 0;
}
