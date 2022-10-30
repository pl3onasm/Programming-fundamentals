/* file: prob2-1.c
* author: David De Potter
* description: problem 2, queen moves, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int row, i, moves;
  char col, j;
  scanf("%c%d", &col, &row);
  /* a queen can always make 7 moves horizontally and
   * 7 vertically, so we can initialize moves to 14 and
   * proceed with checking the possible diagonal moves */
  moves = 14;

  //diagonal to the upper left corner
  i= row+1;
  j= col-1;
  while (i <= 8 && j >= 'a') {
    moves++;
    i++;
    j--;
  }

  //diagonal to the upper right corner
  i= row+1;
  j= col+1;
  while (i <= 8 && j <= 'h') {
    moves++;
    i++;
    j++;
  }

  //diagonal to the lower left corner
  i= row-1;
  j= col-1;
  while (i >= 1 && j >= 'a') {
    moves++;
    i--;
    j--;
  }

  //diagonal to the lower right corner
  i= row-1;
  j= col+1;
  while (i >= 1 && j <= 'h') {
    moves++;
    i--;
    j++;
  }

  printf("%d\n", moves);
  return 0;
}
