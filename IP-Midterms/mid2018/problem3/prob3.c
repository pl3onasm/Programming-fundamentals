/* file: prob3.c
* author: David De Potter
* description: problem 3, rook moves, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int row, x, y; char col;
  (void)! scanf("%c %d", &col, &row); // starting position

  do {
    (void)! scanf("%d %d", &x, &y);
    if (x != 0 && y != 0) break;
    if (col + x <= 'h' && col + x >= 'a') col += x;
    else break;
    if (row + y <= 8 && row + y >= 1) row += y;
    else break;
  } while (x != 0 || y != 0);

  printf(x || y ? "INVALID\n" : "%c%d\n", col, row);
  return 0;
}
