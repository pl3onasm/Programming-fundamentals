/* file: prob3-2.c
   author: David De Potter
   version: 3.2, using a histogram. 
      This version is in O(n).
   description: IP Final 2018, problem 3, sum of pairs
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){
  int target, hist[1001] = {0}, n, solution = 0;
  (void)! scanf("%d\n", &target);
  while (scanf("%d", &n) && n != 0) hist[n] = 1;
  for (int i = 1; i <= target/2; ++i){
    int j = target - i;
    if (j < 1000 && hist[i] && hist[j] && i != j){
      solution = 1; 
      printf("%d+%d\n", i, j); 
    }
  }
  if (! solution) printf("NONE\n");
  return 0; 
}