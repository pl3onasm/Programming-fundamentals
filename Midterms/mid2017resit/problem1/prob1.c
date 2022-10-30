/* file: prob1.c
* author: David De Potter 
* description: problem 1, shell game, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

void swap (int *arr, int i, int j ) {
  /* swaps the content of cells with indexes
   * i and j in the given array */
  int h = arr[i];
  arr[i] = arr[j];
  arr[j] = h;
}

int main(int argc, char *argv[]) {
  int startp, p1, p2, positions[3]={0}; 

  //reads and sets the start position
  scanf("%d ", &startp);
  positions[startp-1] = 1;

  //reads and performs all shuffles
  while (scanf("%d %d", &p1, &p2) == 2)
    swap(positions, p1-1, p2-1);

  /* scans through the array to find and
   * print the ball's final position */
  for (int i = 0; i<3; ++i) {
    if (positions[i]) {
      printf("POSITION %d\n", i+1);
      break;
    }
  }
  return 0;
}