/* file: prob5-1.c
   author: David De Potter
   version: 5.1, this version works with a void function,
     and an int pointer solvable to get the result
   description: IP Final 2017, problem 5, puzzle
*/

#include <stdio.h>
#include <stdlib.h>

void trySteps(int len, int series[], int index, int *solvable){
  if (index < 0 || index >= len || series[index] < 0) return;
  if (index == len-1){ 
    *solvable = 1; return; 
  }
  int step = series[index];
  series [index] = -1;    // mark as seen
  // try step to the right
  trySteps(len, series, index + step, solvable);
  // try step to the left
  trySteps(len, series, index - step, solvable);
  series [index] = step;  // backtrack by restoring the value
} 

int isSolvable(int len, int series[]) {
  int solvable = 0;
  trySteps(len, series, 0, &solvable);
  return solvable;
}

int main(int argc, char *argv[]) {
  int len=0, series[20];
  do {
    (void)! scanf("%d", &series[len]);
    len++;
  } while (series[len-1] != 0);
  printf("%d\n", isSolvable(len, series));
  return 0;
}

