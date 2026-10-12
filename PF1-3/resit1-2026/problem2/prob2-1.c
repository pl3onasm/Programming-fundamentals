/* file: prob2-1.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 2, 
                Bounce to zero
   approach: we simulate the ball's position and direction.
   In each step, we move d positions in the current direction.
   If the move passes an endpoint, we reflect the position
   across that endpoint and reverse the direction. We count the
   steps until the ball reaches position 0.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================

int main() {
  int n, d;
  int count = scanf("%d %d", &n, &d);
  assert(count == 2);

  int iter = 0, num = 1, r = 1;
  while (num != 0) {
    if (r) {
      num += d;
      if (num > n) {
        r = 0;
        num = n - (num - n);
      }
    }
    else {
      num -= d;
      if (num < 0) {
        r = 1;
        num = -num;
      }
    }
    ++iter;
  }

  printf("%d\n", iter);

  return 0;
}