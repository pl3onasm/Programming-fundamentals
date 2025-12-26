/* file: prob3-1.c
   author: David De Potter
   description: extra, problem 3, maximum path
   version: 3.1, both time and space complexity are in O(n²)
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

//=================================================================
// Allocates memory and checks if allocation was successful
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%zu) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Reads a triangle of n rows from stdin
int **readTriangle (size_t n) {
  int **triangle = safeMalloc(n * sizeof(int *));
  for (size_t i = 0; i < n; ++i) {
    triangle[i] = safeMalloc((i + 1) * sizeof(int));
    for (size_t j = 0; j <= i; ++j)
      (void)! scanf("%d ", &triangle[i][j]);
  }
  return triangle;
}

//=================================================================
// Frees the memory allocated to a 2D array
void free2Dmem (int **arr, size_t n) {
  for (size_t i = 0; i < n; ++i)
    free(arr[i]);
  free(arr);
}

//=================================================================
// Computes the maximum path cost in a triangle of n rows
int maxPath (int **triangle, size_t n) {
  int max;

    // calculate the maximum path cost for each cell
  for (size_t i = 1; i < n; ++i) {
    for (size_t j = 0; j <= i; ++j) {
      max = 0;
      if (j < i) max = triangle[i - 1][j];
      if (j > 0) max = MAX(max, triangle[i - 1][j - 1]);
      triangle[i][j] += max;
    }
  }
  
    // take maximum of the last row
  max = triangle[n - 1][0];
  for (size_t j = 1; j < n; ++j)
    max = MAX(max, triangle[n - 1][j]);

  return max;
}

//=================================================================

int main() {
  size_t n;
  assert(scanf("%zu", &n) == 1);

  int **triangle = readTriangle(n);

  printf("%d\n", maxPath(triangle, n));

  free2Dmem(triangle, n);
  
  return 0;
}