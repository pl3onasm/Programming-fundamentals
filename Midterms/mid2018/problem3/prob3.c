/* file: prob3.c
* author: David De Potter
* description: problem 3, rook moves, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int row, x, y, flag=0;
  char col;
  scanf("%c %d", &col, &row); // starting position

  do {
    scanf("%d %d", &x, &y);
    if (x != 0 && y != 0) break;
    if (col+x <= 'h' && col+x >= 'a') col += x;
    else break;
    if (row+y <= 8 && row+y >= 1) row += y;
    else break;
  } while (x != 0 || y != 0);

  if (x==0 && y==0) printf("%c%d\n", col, row);
  else printf("INVALID\n");
  return 0;
}
