/* 
  file: prob4-1.c
  author: David De Potter
  description: PF 3/3rd term 2024, problem 4, maximal f-sum
  note: naive but working solution for n < 20. The problem is a variant  
    of the rod-cutting problem, see:
    https://github.com/pl3onasm/CLRS/tree/main/algorithms/dynamic-programming/rod-cutting
  time complexity: O(2^n)
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#define MAX(a, b) ((a) > (b) ? (a) : (b))

//=================================================================
// Reads the input from stdin into an array
void readInput(int f[], int *n) {
  assert(scanf("%d:", n) == 1);
  for (int i = 0; i < *n; i++) 
    assert(scanf("%d", &f[i]) == 1);
}

//=================================================================
// Computes the maximal f-sum for n. Precondition: n < 20,
// since the time complexity is in O(2^n) !!
int maxfSum(int f[], int n) {
  if (n == 0) 
    return 0;
  int max = -1;
  for (int i = 1; i <= n; i++)
    max = MAX(max, f[i - 1] + maxfSum(f, n - i));
  return max;
}

//=================================================================

int main() {
  int f[100], n;

  readInput(f, &n);
  printf("%d\n", maxfSum(f, n));
  
  return 0;
}