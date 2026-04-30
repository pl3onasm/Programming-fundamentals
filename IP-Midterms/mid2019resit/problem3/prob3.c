/* file: prob3.c
   author: David De Potter
   description: IP mid2019 resit, problem 3,
   difference of squares
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n, count = 0;
  
  assert(scanf("%d", &n) == 1);

  for (int z = 0; z <= n; ++z) {
    for (int y = z; y <= n; ++y) {
      int sum = z*z + y*y;
      int x = y;
      int xsq = x*x;
      while (xsq - sum < n) {
        xsq += 2*x + 1;         // (x+1)^2 = x^2 + 2x + 1
        ++x;
      }
      if (xsq - sum == n) ++count;
    }
  }

  printf("%d\n", count);
  return 0;
}
