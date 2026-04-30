/* file: prob4.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 4, maximal sum
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main(){ 
  int sum = 0, max = 0, n; 
    // Since at least one number is positive, the maximal subseries 
    // sum is > 0. Therefore initializing max = 0 is safe.
    // sum holds the running sum of the current candidate subseries 
    // When it becomes negative we reset it to 0, because a 
    // negative prefix can never help a future maximum.
  while (scanf("%d", &n) == 1 && n != 0) {
    sum += n;
    if (sum > max)    // update max
      max = sum;
    if (sum < 0)      // reset sum
      sum = 0;
  }
  printf("%d\n", max);
  return 0; 
}
