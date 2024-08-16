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

#include "../../Functions/clib/clib.h"

int maxPath (int n) {
  /* computes the maximum path cost */
  // read the first row
  CREATE_ARRAY(int, row1, n, 0);
  CREATE_ARRAY(int, row2, n, 0);
  
  READ_ARRAY(row1, "%d ", 1);

  for (int i = 1; i < n; ++i) {
    // read the next row
    READ_ARRAY(row2, "%d ", i + 1);
    
    // calculate the maximum path cost for each cell
    for (int j = 0; j <= i; ++j) {
      int max = 0;
      if (j < i) max = row1[j];
      if (j > 0) max = MAX(max, row1[j - 1]);
      row2[j] += max;
    }
    SWAP(row1, row2);
  }

  // take maximum of the last row
  int max = row1[0];
  for (int j = 1; j < n; ++j)
    max = MAX(max, row1[j]);

  free(row1);
  free(row2);
  return max;
}


int main() {
  int n;
  (void)! scanf("%d ", &n);
 
  printf("%d\n", maxPath(n));

  return 0;
}
