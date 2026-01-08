/* file: prob4.c
   author: David De Potter
   description: problem 4, digital spiral sum, mid2015
   approach: we do not need to construct the n x n grid.

   The spiral is built in consecutive "legs" whose lengths grow:
   starting from the center we go

      1 step down   (leg 1),
      1 step left   (leg 2),
      2 steps up    (leg 3),
      2 steps right (leg 4),
      3 steps down  (leg 5),
      3 steps left  (leg 6),
      ...

   The ascending diagonal cells (as shown in the figure) are 
   exactly the positions reached at the end of every second leg: 
     leg 2, leg 6, leg 10, ...
   To go from one such diagonal cell to the next, we follow the 
   spiral until the end of the next "second leg", and the number 
   of steps taken between successive diagonal cells is 2, then 4, 
   then 6, ...

   Since the values in the spiral increase by 1 per step, the 
   diagonal values form:
      m
      m + 2
      m + 2 + 4
      m + 2 + 4 + 6
      ...
      
   So we can compute the required sum by accumulating these 
   increments without storing the whole grid.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int m, n, sum = 0;
  assert(scanf("%d %d", &n, &m) == 2);
  
  for (int i = 0; i < n; ++i){
    m += i * 2;
    sum += m;
  }
  
  printf("%d\n", sum);

  return 0;
}
