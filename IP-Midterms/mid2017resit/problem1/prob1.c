/* file: prob1.c
* author: David De Potter 
* description: problem 1, shell game, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

void swap(int *a, int *b) {
  //swaps the values of a and b
  int temp = *a;
  *a = *b;
  *b = temp;
}

int main(int argc, char *argv[]) {
  int startp, p1, p2, positions[3] = {0}; 

  //reads and sets the start position
  (void)! scanf("%d ", &startp);
  positions[startp - 1] = 1;

  //reads and performs all shuffles
  while (scanf("%d %d", &p1, &p2) == 2)
    swap(&positions[p1-1], &positions[p2-1]);

  /* scans through the array to find and
   * print the ball's final position */
  for (int i = 0; i < 3; ++i) {
    if (positions[i]) {
      printf("POSITION %d\n", i+1);
      break;
    }
  }
  return 0;
}