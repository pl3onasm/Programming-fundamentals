/* file: prob4a.c
   author: David De Potter
   description: IP Final 2012, problem 4a, 
   Iterative algorithms, permutations
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if two arrays are permutations of each other by comparing
// the frequency of each digit (0-9) in both arrays
int isPermutation(int length, int a[], int b []) {
  int digits[10] = {0};

  for (int i = 0; i < length; ++i) {
    ++digits[a[i]];
    --digits[b[i]];
  }

  for (int i = 0; i < 10; ++i) 
    if (digits[i] != 0)
      return 0;

  return 1;
}

//=================================================================

int main() {
  int a[1000], b[1000], n;
  assert(scanf("%d", &n) == 1);

  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", &a[i]) == 1);
  
  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", &b[i]) == 1);
  
  printf(isPermutation(n, a, b) ? "YES\n": "NO\n");
  
  return 0;
}