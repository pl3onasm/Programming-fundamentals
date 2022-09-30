/* file: game.c
* author: David De Potter 
* version: 1.0
* description: problem 1, shell game, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

void swap (int *positions, int i, int j ) {
  /* swaps the content of cells with indexes
   * a and b in the given array */
  int h = positions[i];
  positions[i] = positions[j];
  positions[j] = h;
  return;
}

int main(int argc, char *argv[]) {
  int startp, p1, p2;
  int positions[3];

  //reads and sets the start position
  scanf("%d ", &startp);
  positions[startp-1] = 1;

  //reads and performs all shuffles
  while (scanf("%d %d", &p1, &p2) == 2)
    swap(positions, p1-1, p2-1);

  /* scans through the array to find and
   * print the ball's final position */
  for (int i = 0; i<3; ++i) {
    if (positions[i] == 1) {
      printf("POSITION %d\n", i+1);
      break;
    }
  }
  return 0;
}