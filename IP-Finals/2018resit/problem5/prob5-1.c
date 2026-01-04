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
#include <assert.h>

//=================================================================
// Checks whether the substring s[start..end] is a palindrome
int isPalindrome(char *s, int start, int end) {
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(s, start + 1, end - 1);
}

//=================================================================
// Recursively makes all possible palindromic partitions of
// the substring a[left..right], updating min with the
// minimal number of partitions found
void makePartitions(int left, int right, char *a, int *min, 
                    int count) {

    // base case: no more characters to partition
  if (left > right) {
    *min = count < *min ? count : *min;
    return;
  }
  
    // prune branches that are already worse than current 
    // min to avoid unnecessary computations
  if (count >= *min)
    return;

    // recursive case: try all possible palindromic prefixes
  for (int j = left; j <= right; ++j) 
    if (isPalindrome(a, left, j)) 
      makePartitions(j + 1, right, a, min, count + 1);
}

//=================================================================
// Computes the minimal number of palindromic partitions
// of the string a[left..right]
int minimalPalPartition(int left, int right, char *a) {
  int min = INT_MAX;
  makePartitions (left, right, a, &min, 0);
  return min;
}

//=================================================================

int main() {
  char a[21];
  assert(scanf("%s", a) == 1);

  printf("%d\n", minimalPalPartition(0, strlen(a) - 1, a));

  return 0;
}
