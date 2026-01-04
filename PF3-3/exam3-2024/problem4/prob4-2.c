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
void readInput(int f[], int *n) {
  assert(scanf("%d:", n) == 1);
  for (int i = 0; i < *n; i++)
    assert(scanf("%d", &f[i]) == 1);
}

//=================================================================
// Computes the maximal f-sum that can be obtained for size
int maxfSum(int f[], int n, int memo[]) {
    // base case
  if (n == 0)         
    return 0;
    // return memoized value if available
  if (memo[n - 1] != -1)   
    return memo[n - 1];
    // otherwise compute and memoize
  int max = -1;
  for (int i = 1; i <= n; ++i) {
    int cand = f[i - 1] + maxfSum(f, n - i, memo);
    if (cand > max) max = cand;
  }
  return memo[n - 1] = max;
}

//=================================================================

int main() {
  int f[100], n = 0, memo[100];

  readInput(f, &n);

  for (int i = 0; i <= n; i++)
    memo[i] = -1;

  printf("%d\n", maxfSum(f, n, memo));
  
  return 0;
}