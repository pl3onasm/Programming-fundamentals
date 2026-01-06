/* file: prob1.c
   author: David De Potter
   description: problem 1, minimum bounding rectangle, 
     resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

//=================================================================

int main() {
  int n, x0, y0, x1, y1, x2, y2;
  int maxx, maxy, minx, miny;

  assert(scanf("%d", &n) == 1);

  assert(scanf("%d %d %d %d %d %d",
               &x0, &y0, &x1, &y1, &x2, &y2) == 6);

  maxx = MAX(x0, MAX(x1, x2));
  minx = MIN(x0, MIN(x1, x2));
  maxy = MAX(y0, MAX(y1, y2));
  miny = MIN(y0, MIN(y1, y2));

  for (int i = 2; i <= n; ++i) {
    assert(scanf("%d %d %d %d %d %d",
                 &x0, &y0, &x1, &y1, &x2, &y2) == 6);

    maxx = MAX(maxx, MAX(x0, MAX(x1, x2)));
    minx = MIN(minx, MIN(x0, MIN(x1, x2)));
    maxy = MAX(maxy, MAX(y0, MAX(y1, y2)));
    miny = MIN(miny, MIN(y0, MIN(y1, y2)));
  }

  printf("%d %d %d %d\n", minx, miny, maxx, maxy);
  return 0;
}