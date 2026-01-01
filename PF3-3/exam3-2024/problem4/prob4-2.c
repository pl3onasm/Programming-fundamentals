/* 
  file: prob4-2.c
  author: David De Potter
  description: PF 3/3rd term 2024, problem 4, maximal f-sum
  note: using memoization to reduce time complexity. The problem is a variant  
    of the rod-cutting problem, see:
    https://github.com/pl3onasm/CLRS/tree/main/algorithms/dynamic-programming/rod-cutting
  time complexity: O(n^2)
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Reads the input from stdin into an array
void readInput(int f[], int *size) {
  assert(scanf("%d:", size) == 1);
  for (int i = 0; i < *size; i++)
    assert(scanf("%d", &f[i]) == 1);
}

//=================================================================

int maxfSum(int f[], int size, int memo[]) {
    // base case
  if (size == 0)         
    return 0;
    // return memoized value if available
  if (memo[size - 1] != -1)   
    return memo[size - 1];
    // otherwise compute and memoize
  int max = -1;
  for (int i = 1; i <= size; ++i) {
    int cand = f[i - 1] + maxfSum(f, size - i, memo);
    if (cand > max) max = cand;
  }
  return memo[size - 1] = max;
}

//=================================================================

int main() {
  int f[100], size = 0, memo[100];

  readInput(f, &size);

  for (int i = 0; i <= size; i++)
    memo[i] = -1;

  printf("%d\n", maxfSum(f, size, memo));
  
  return 0;
}