/* file: prob4.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 4, maximal sum
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){ 
  int sum = 0, max = 0, n; 
  // since at least one number is positive, the max sum is at least 0
  while (scanf("%d", &n) && n != 0) {
    sum += n;
    if (sum > max)    // update max
      max = sum;
    if (sum < 0)      // reset sum
      sum = 0;
  }
  printf("%d\n", max);
  return 0; 
}
