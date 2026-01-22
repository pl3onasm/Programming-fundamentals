/* 
  file: prob4.c
  author: David De Potter
  description: 3-3rd exam 2026, problem 4, balanced partition

  Note:
    This recursive solution explores all assignments of digits to the
    two sets L and R. In the worst case this takes exponential time,
    because the recursion may revisit the same subproblems 
    repeatedly.
    Using memoization (caching by index and sum difference) avoids
    recomputation and speeds up the algorithm significantly.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Counts the number of balanced partitions of arr[0..n-1], where
// each arr[i] is a digit (0..9)
int countBalParts(int *arr, int n, int idx, 
                  int sumL, int sumR, int rem) {
  
    // Prune branches where balance is impossible
    // to avoid unnecessary recursion
  if (sumL > sumR + rem || sumR > sumL + rem)
    return 0;

    // Base case: all elements have been assigned
    // Check if sums are equal
  if (idx == n)
    return (sumL == sumR) ? 1 : 0;

    // Recursive case: assign arr[idx] to L or R
  int countL = countBalParts(arr, n, idx + 1, sumL + arr[idx], 
                             sumR, rem - arr[idx]);

  int countR = countBalParts(arr, n, idx + 1, sumL, 
                             sumR + arr[idx], rem - arr[idx]);

  return countL + countR;
}

//===================================================================
// Reads the input from stdin and returns the total sum of the array
int readInput(int *arr, int len) {
  int sum = 0;
  for (int i = 0; i < len; ++i) {
    assert(scanf(" %d", &arr[i]) == 1);
    sum += arr[i];
  }
  return sum;
}

//===================================================================

int main(){
  int n, arr[32];

  assert(scanf("%d", &n) == 1);

  int totalSum = readInput(arr, n);
    
    // We enforce partitions L to always include arr[0] to avoid
    // counting duplicates where L and R can be swapped
  int rem = totalSum - arr[0];

  int count = countBalParts(arr, n, 1, arr[0], 0, rem);

  printf("%d\n", count);

  return 0;
}

