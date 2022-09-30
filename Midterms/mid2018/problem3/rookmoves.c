/* file: rookmoves.c
* author: David De Potter
* description: problem 3, rook moves, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int row, x, y;
  char col;
  //reads in starting position
  scanf("%c %d", &col, &row);
  //reads coordinates of first move
  scanf("%d %d", &x, &y);

  while (x != 0 || y != 0) {
    if (x != 0 && y != 0) {
      //invalid move for a rook
      printf("INVALID\n");
      break;
    }
    if (x > 0) {
      if (col+x <= 'h') col += x;
      else { //out of boundaries
        printf("INVALID\n");
        break;
      }
    } else {  //x is negative
      if (col+x >= 'a') col += x;
      else {
        printf("INVALID\n");
        break;
      }
    }
    if (y > 0) {
      if (row+y <= 8) row += y;
      else {
        printf("INVALID\n");
        break;
      }
    } else { //y is negative
      if (row+y >= 1) row += y;
      else {
        printf("INVALID\n");
        break;
      }
    }
    //reads coordinates of next move
    scanf("%d %d", &x, &y);
  }
  if ((x == 0) & (y == 0))
    /* if true, scanning reached the last line
     * without encountering any invalid moves */
    printf("%c%d\n", col, row);
  return 0;
}
