/* file: prob5.c
   author: David De Potter
   description: IP Final 2017, problem 5, puzzle
*/

#include <stdio.h>
#include <stdlib.h>

void trySteps(int len, int series[], int index, int *solved, int seen[]){
  if (index == len-1){ 
    *solved=1; return; 
  }
  if (index < 0 || index >= len || seen[index]) return;
  int step = series[index];
  seen [index] = 1;
  // try step to the right
  trySteps(len, series, index+step, solved, seen);
  // try step to the left
  trySteps(len, series, index-step, solved, seen);
  seen [index] = 0;   //backtrack
} 

int isSolvable(int len, int series[]) {
  int solved=0, seen[20]={0};
  trySteps(len, series, 0, &solved, seen);
  return solved;
}

int main(int argc, char *argv[]) {
  int len=0, series[20];
  do {
    scanf("%d", &series[len]);
    len++;
  } while (series[len-1] != 0);
  printf("%d\n", isSolvable(len, series));
  return 0;
}
