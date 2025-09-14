/* file: prob3.c
* author: David De Potter
* description: IP mid2019 resit, problem 3,
* difference of squares
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, count = 0;
  (void)! scanf("%d", &n);

  for (int z = 0; z <= n; ++z) {
    for (int y = z; y <= n; ++y) {
      int sum = z*z + y*y;
      int x = y;
      while (x*x - sum < n) x++;
      if (x*x - sum == n) count++;
    }
  }

  printf("%d\n", count);
  return 0;
}
