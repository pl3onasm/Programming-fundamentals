/* file: prob4.c
* author: David De Potter
* description: problem 4, run-length encoding, mid2013
*/

#include <stdio.h>
#include <stdlib.h>

int **matrix;

void createMatrix(int m, int n) {
  //creates a m x n null matrix
  matrix = calloc(m,sizeof(int*));
  for (int i=0; i<m; ++i)
    matrix[i] = calloc(n,sizeof(int));
  return;
}

void freeMem (int m) {
  //frees dynamically allocated memory
  for (int row = 0; row < m; ++row)
    free(matrix[row]);
  free(matrix);
}

int main(int argc, char *argv[]) {
  int m=0, n=0, runs=0, row=0, col=0, length=0;

  scanf("%d %d", &m, &n);
  createMatrix(m, n); //default null matrix
  scanf("%d", &runs);

  //adjusts rows in matrix to reflect the given runs
  for (int i = 0; i < runs; ++i) {
    scanf("%d %d %d", &row, &col, &length);
    for (int j = 0; j <= length - 1; ++j)
      matrix[row][col + j] = 1;
  }
  //prints the resulting binary image
  for (int i = 0; i < m; ++i){
    for (int j = 0; j < n; ++j)
      printf("%d", matrix[i][j]);
    printf("\n");
  }

  freeMem(m);
  return 0;
}
