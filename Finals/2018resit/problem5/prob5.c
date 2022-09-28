/* file: prob5.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 5,
  0 minimal palindromic partition
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int isPalindrome(char *s, int start, int end) {
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(s, start+1, end-1);
}

int minimum (int a, int b) {
  return (a < b) ? a : b;
}

void partitionGenerator(int i, char *a, int size, int *min, int *count) {
  if (i > size) {
    *min = minimum(*min, *count);
    return;
  }
  for (int j = i; j <= size; j++) {
    if (isPalindrome(a, i, j)) {
      *count += 1;
      partitionGenerator(j+1, a, size, min, count);
      *count -= 1;	// backtrack
    }
  }
}

int minimalPalPartition(int i, int size, char *a) {
  int min = INT_MAX, count = 0;
  partitionGenerator (i, a, size, &min, &count);
  return min;
}

int main(int argc, char *argv[]) {
  char a[21];
  scanf("%s", a);
  printf("%d\n", minimalPalPartition(0, strlen(a)-1, a));
  return 0;
}
