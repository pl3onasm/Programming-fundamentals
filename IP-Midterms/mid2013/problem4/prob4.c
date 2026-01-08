/* file: prob4.c
   author: David De Potter
   description: problem 4, run-length encoding, mid2013
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks for allocation errors
void *safeCalloc (size_t n, size_t k) {
  void *p = calloc(n, k);
  if (p == NULL) {
    fprintf(stderr, "Error: calloc(%zu, %zu) failed. " 
                    "Out of memory?\n", n, k);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Creates an m x n matrix initialized to zero
int **createMatrix(int m, int n) {
  int **matrix = safeCalloc(m,sizeof(int*));
  for (int i = 0; i < m; ++i)
    matrix[i] = safeCalloc(n,sizeof(int));
  return matrix;
}

//=================================================================
// Deallocates memory used by an m x n matrix
void freeMem (int **matrix, int m) {
  for (int row = 0; row < m; ++row)
    free(matrix[row]);
  free(matrix);
}

//=================================================================

int main() {
  int m, n, runs, row, col, length;

  assert(scanf("%d %d", &m, &n) == 2);
  int **matrix = createMatrix(m, n); 
  
  assert(scanf("%d", &runs) == 1);

    // adjust rows in matrix to reflect the given runs
  for (int i = 0; i < runs; ++i) {
    assert(scanf("%d %d %d", &row, &col, &length) == 3);
    for (int j = 0; j < length; ++j)
      matrix[row][col + j] = 1;
  }

    // print the resulting binary image
  for (int i = 0; i < m; ++i){
    for (int j = 0; j < n; ++j)
      printf("%d", matrix[i][j]);
    printf("\n");
  }

  freeMem(matrix, m);
  return 0;
}
