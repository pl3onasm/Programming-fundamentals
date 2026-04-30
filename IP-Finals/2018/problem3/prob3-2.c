/* file: prob3-2.c
   author: David De Potter
   version: 3.2, using a histogram. 
      This version is in O(n).
   description: IP Final 2018, problem 3, sum of pairs
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main(){
  int target, hist[1000] = {0}, n, solution = 0;
  assert(scanf("%d", &target) == 1);

  while (scanf("%d", &n) == 1 && n != 0) 
    hist[n] = 1;

  int upper = target / 2;
  if (target > 999) 
    upper = 999;
  
  for (int i = 1; i <= upper; ++i){
    int j = target - i;
    if (0 <= j && j < 1000 && hist[i] && hist[j] && i < j){
      solution = 1; 
      printf("%d+%d\n", i, j); 
    }
  }

  if (! solution) printf("NONE\n");

  return 0; 
}