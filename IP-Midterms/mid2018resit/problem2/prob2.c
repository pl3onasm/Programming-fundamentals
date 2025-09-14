/* file: prob2.c
* author: David De Potter
* description: problem 2, queen moves, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int row, moves;
  char col;
  
  (void)! scanf("%c%d", &col, &row);
  
  /* a queen can always make 7 moves horizontally and
   * 7 vertically, so we can initialize moves to 14 and
   * proceed with checking the possible diagonal moves */
  moves = 14;

  int steps[] = {1, -1, 1, 1, -1, -1, -1, 1}; 

  for (int i = 0; i < 8; i += 2) {
    int x = steps[i];
    int y = steps[i + 1];
    while (col + x <= 'h' && col + x >= 'a' && row + y <= 8 && row + y >= 1) {
      moves++;
      x += steps[i];
      y += steps[i + 1];
    }
  }

  printf("%d\n", moves);
  return 0;
}