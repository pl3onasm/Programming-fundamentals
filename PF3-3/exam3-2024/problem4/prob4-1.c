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
void readInput(int f[], int *size) {
  assert(scanf("%d:", size) == 1);
  for (int i = 0; i < *size; i++) 
    assert(scanf("%d", &f[i]) == 1);
}

//=================================================================
// Computes the maximal f-sum for size. Precondition: size < 20,
// since the time complexity is in O(2^n) !!
int maxfSum(int f[], int size) {
  if (size == 0) 
    return 0;
  int max = -1;
  for (int i = 1; i <= size; i++)
    max = MAX(max, f[i - 1] + maxfSum(f, size - i));
  return max;
}

//=================================================================

int main(int argc, char *argv[]) {
  int f[100], size;

  readInput(f, &size);

  printf("%d\n", maxfSum(f, size));
  
  return 0;
}