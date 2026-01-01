/* 
  file: prob4.c
  author: David De Potter
  description: PF 3/3rd term 2025, problem 4, 
                Interleaving arrays
  approach:
    The problem statement guarantees that each input array has length
    at most 50, so we use plain recursion here: at position k = i + j
    in C, we try to take the next element either from A (advance i)
    or from B (advance j), while preserving the relative order inside
    A and inside B.
  efficiency:
    Even though this approach works well for the given test cases,
    recursion can be exponential in the worst case when many elements
    are equal, because the same (i,j) subproblems may be recomputed
    in different branches. A memoized version (caching the result for
    each (i,j) pair) avoids this repetition and runs in O(|A|*|B|)
    time.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Allocates memory for n bytes, exits if malloc fails
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%zu) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//===================================================================
// Reads the input from stdin and returns an array of integers
int *readInput(int *size) {
  assert(scanf("%d:", size) == 1);
  int *arr = safeMalloc(*size * sizeof(int));
  for (int i = 0; i < *size; i++) 
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
}

//===================================================================
// Returns 1 iff C is an interleaving of A and B from positions (i,j)
int isInterl(int *arrA, int sizeA, int *arrB, int sizeB,
                      int *arrC, int i, int j) {

    // Base case: reached the end of both A and B
  if (i == sizeA && j == sizeB)
    return 1;

    // Recursive case: try to take next from A or from B
  int k = i + j;                 
  if (i < sizeA && arrA[i] == arrC[k])
    if (isInterl(arrA, sizeA, arrB, sizeB, arrC, i + 1, j))
      return 1;

  if (j < sizeB && arrB[j] == arrC[k])
    if (isInterl(arrA, sizeA, arrB, sizeB, arrC, i, j + 1))
      return 1;

  return 0;
}

//===================================================================

int main() {
  int sizeA, sizeB, sizeC;
  int *arrA = readInput(&sizeA);
  int *arrB = readInput(&sizeB);
  int *arrC = readInput(&sizeC);

  if (sizeA + sizeB != sizeC) 
    printf("NO\n");
  else if (isInterl(arrA, sizeA, arrB, sizeB, arrC, 0, 0))
    printf("YES\n");
  else 
    printf("NO\n");

  free(arrA);
  free(arrB);
  free(arrC);
  
  return 0;
}