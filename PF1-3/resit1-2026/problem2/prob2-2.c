/* file: prob2-2.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 2, 
                Bounce to zero
   approach: we represent the bouncing path as a cycle of
   length 2 * n. The first half represents movement from 0
   to n, and the second half represents the return to 0.
   Starting at cycle position 1, each step advances d positions,
   wrapping around using modulo 2 * n. We count the steps until 
   cycle position 0 is reached.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================

int main() {
  int n, d;
  int count = scanf("%d %d", &n, &d);
  assert(count == 2);

  int iter = 0, position = 1;

  while (position != 0) {
    position = (position + d) % (2 * n);
    ++iter;
  }

  printf("%d\n", iter);

  return 0;
}