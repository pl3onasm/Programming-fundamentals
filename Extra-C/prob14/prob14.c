/* 
  file: prob14.c
  author: David De Potter
  description: extra, problem 14, columnar transposition
  time complexity: O(L + n), where L = text length, 
                                   n = number of columns
  Approach:
  - The second input line gives a permutation of the digits 1..n, 
    which indicates the reading order of the n columns.
  - We do not build an explicit 2D grid. Instead, we use index 
    arithmetic: character at (row, col) in an n-column grid is at 
    linear index row*n + col.
    Reading a column top-to-bottom means visiting indices:
      col, col + n, col + 2n, ...
  - We first compute an inverse mapping pos[label] = column index, 
    so that we can output columns in label order 1..n.
*/

#include "../../Functions/include/clib/macros.h"


//=================================================================

int main() {
  char *text, *order;
  size_t *pos, textSize, nCols;

    // Read text to be encoded
  C_READ_LINE(text, textSize);

    // Read the column order as a string of digits
  C_READ_LINE(order, nCols);

    // pos[label] = column index that has this label
    // labels are in 1..nCols so we need nCols + 1 entries
  C_NEW_ARRAY(size_t, pos, nCols + 1);

    // Build inverse mapping
  for (size_t col = 0; col < nCols; ++col) {
    size_t label = order[col] - '0';
    pos[label] = col;
  }

    // Output the encoded text by reading columns in ascending 
    // label order. For a given column col, the chars in that 
    // column are at indices: col, col + nCols, col + 2*nCols, ...
  for (size_t label = 1; label <= nCols; ++label) {
    size_t col = pos[label];
    for (size_t idx = col; idx < textSize; idx += nCols) 
      printf ("%c", text[idx]);
  }

  printf ("\n");
  free (text);
  free (order);
  free (pos);

  return 0;
}
