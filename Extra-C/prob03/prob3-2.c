/* 
  file: prob3-2.c
  author: David De Potter
  description: extra, problem 3, maximum path
  version: 3.2, using clib library 
    also changed the implementation to use only two
    rows of size n instead of a 2D array of size n²
    Time complexity is still O(n²), but the space 
    complexity is now O(n) instead of O(n²) 
*/

#include "../../Functions/include/clib/clib.h"

//=================================================================
// Computes the maximum path cost in a triangle of n rows
int maxPath (size_t n) {
    // read the first row
  int *row1, *row2;
  C_NEW_ARRAY(int, row1, n);
  C_NEW_ARRAY(int, row2, n);
  
  C_READ_ARRAY(row1, "%d ", 1);

  for (size_t i = 1; i < n; ++i) {
      // read the next row
    C_READ_ARRAY(row2, "%d ", i + 1);
    
      // calculate the maximum path cost for each cell
    for (size_t j = 0; j <= i; ++j) {
      int max = 0;
      if (j < i) max = row1[j];
      if (j > 0) max = C_MAX(max, row1[j - 1]);
      row2[j] += max;
    }
    C_SWAP(row1, row2);
  }

    // take maximum of the last row
  int max = row1[0];
  for (size_t j = 1; j < n; ++j)
    max = C_MAX(max, row1[j]);

  free(row1);
  free(row2);
  return max;
}

//=================================================================

int main() {
  size_t n;
  assert(scanf("%zu ", &n) == 1);
 
  printf("%d\n", maxPath(n));

  return 0;
}
