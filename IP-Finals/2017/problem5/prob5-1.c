/* file: prob5-1.c
   author: David De Potter
   version: 5.1, this version works with a void function,
     and an int pointer solvable to get the result
   description: IP Final 2017, problem 5, puzzle
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Depth-first search with backtracking to explore possible steps
void trySteps(int len, int series[], int index, int *solvable){
    
    // base case: out of bounds or already seen
  if (index < 0 || index >= len || series[index] < 0) 
    return;
  
    // base case: reached the end successfully
  if (index == len - 1){ 
    *solvable = 1; 
    return; 
  }

    // recursive cases: explore both possible steps  
  int step = series[index];
    // mark current position as seen
  series [index] = -1;    
    // try a step to the right
  trySteps(len, series, index + step, solvable);
    // try a step to the left
  trySteps(len, series, index - step, solvable);
    // backtrack by unmarking and restoring original value
  series [index] = step;  
} 

//=================================================================
// Initiates the recursive checking of solvability
int isSolvable(int len, int series[]) {
  int solvable = 0;
  trySteps(len, series, 0, &solvable);
  return solvable;
}

//=================================================================

int main() {
  int len=0, series[20];
  do {
    assert(scanf("%d", &series[len]) == 1);
    len++;
  } while (series[len-1] != 0);
  printf("%d\n", isSolvable(len, series));
  return 0;
}

