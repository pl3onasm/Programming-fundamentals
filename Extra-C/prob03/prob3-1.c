/* file: prob3-1.c
   author: David De Potter
   description: extra, problem 3, maximum path
   version: 3.1, both time and space complexity are in O(n²)
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

void *safeMalloc (int n) {
  /* allocates memory and checks whether it was successful */
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int **readTriangle (int n) {
  /* reads the triangle from stdin */
  int **triangle = safeMalloc(n * sizeof(int *));
  for (int i = 0; i < n; ++i) {
    triangle[i] = safeMalloc((i + 1) * sizeof(int));
    for (int j = 0; j <= i; ++j)
      (void)! scanf("%d ", &triangle[i][j]);
  }
  return triangle;
}

void free2Dmem (int **arr, int n) {
  /* frees the memory allocated to a 2D array */
  for (int i = 0; i < n; ++i)
    free(arr[i]);
  free(arr);
}

int maxPath (int **triangle, int n) {
  /* computes the maximum path cost */
  int i, j, max;

  // calculate the maximum path cost for each cell
  for (i = 1; i < n; ++i) {
    for (j = 0; j <= i; ++j) {
      max = 0;
      if (j < i) max = triangle[i - 1][j];
      if (j > 0) max = MAX(max, triangle[i - 1][j - 1]);
      triangle[i][j] += max;
    }
  }
  
  // take maximum of the last row
  max = triangle[n - 1][0];
  for (j = 1; j < n; ++j)
    max = MAX(max, triangle[n - 1][j]);

  return max;
}

int main() {
  int n;
  (void)! scanf("%d", &n);

  int **triangle = readTriangle(n);

  printf("%d\n", maxPath(triangle, n));

  free2Dmem(triangle, n);
  
  return 0;
}