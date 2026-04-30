/* file: prob3.c
   author: David De Potter
   description: problem 3, rook moves, mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int row, x, y; 
  char col;

    // read initial position
  assert(scanf(" %c %d", &col, &row) == 2); 

  do {
    assert(scanf("%d %d", &x, &y) == 2);
    if (x != 0 && y != 0) 
      break;
    if (col + x <= 'h' && col + x >= 'a') 
      col += x;
    else break;
    if (row + y <= 8 && row + y >= 1) 
      row += y;
    else break;
  } while (x != 0 || y != 0);

  printf(x || y ? "INVALID\n" : "%c%d\n", col, row);
  return 0;
}
