/* file: prob5-2.c
   author: David De Potter
   version: 5.2, this version works with an int function to
      compute the truth value of whether the puzzle is solvable 
   description: IP Final 2017, problem 5, puzzle
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Depth-first search with backtracking to explore possible steps
int trySteps(int len, int series[], int index){ 

    // base case: out of bounds or already seen
  if (index < 0 || index >= len || series[index] < 0) 
    return 0;

    // base case: reached the end successfully
  if (index == len-1) 
    return 1;
    
    // recursive cases: explore both possible steps
  int step = series[index];
    // mark current position as seen
  series [index] = -1;    
    // try a step to the right or to the left
  int solvable = trySteps(len, series, index + step)
              || trySteps(len, series, index - step);
    // backtrack by unmarking and restoring original value
  series [index] = step;  
  return solvable; 
} 

//=================================================================
// Initiates the recursive checking of solvability
int isSolvable(int len, int series[]) {
  return trySteps(len, series, 0);
}

//=================================================================
int main() {
  int len = 0, series[20];
  do {
    assert(scanf("%d", &series[len]) == 1);
    len++;
  } while (series[len-1] != 0);
  printf("%d\n", isSolvable(len, series));
  return 0;
}

