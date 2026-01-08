/* file: prob1.c
* author: David De Potter
* description: problem 1, shell game, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int pos, p1, p2;

  assert(scanf("%d", &pos) == 1);

  while (1) {
    assert(scanf("%d", &p1) == 1);
    if (p1 == 0) break;
    assert(scanf("%d", &p2) == 1);

    if (pos == p1) pos = p2;
    else if (pos == p2) pos = p1;
  }

  printf("POSITION %d\n", pos);
  return 0;
}
