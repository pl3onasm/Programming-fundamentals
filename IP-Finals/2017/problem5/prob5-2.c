/* file: prob5-2.c
   author: David De Potter
   version: 5.2, this version works with an int function to
      compute the truth value of whether the puzzle is solvable 
   description: IP Final 2017, problem 5, puzzle
*/

#include <stdio.h>
#include <stdlib.h>

int trySteps(int len, int series[], int index){
  if (index < 0 || index >= len || series[index] < 0) return 0;
  if (index == len-1) return 1; 
  int step = series[index];
  series [index] = -1;    // mark as seen
  // try step to the right or to the left
  int solvable = trySteps(len, series, index + step)
              || trySteps(len, series, index - step);
  series [index] = step;  // backtrack by restoring the value
  return solvable; 
} 

int isSolvable(int len, int series[]) {
  return trySteps(len, series, 0);
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

