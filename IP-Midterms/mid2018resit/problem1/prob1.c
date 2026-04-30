/* file: prob1.c
   author: David De Potter
   description: problem 1, minimum bounding rectangle, 
     resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MAX(a, b)        ((a) > (b) ? (a) : (b))
#define MIN(a, b)        ((a) < (b) ? (a) : (b))
#define MAX3(a, b, c)    (MAX((a), MAX((b),  (c))))
#define MIN3(a, b, c)    (MIN((a), MIN((b),  (c))))
#define MAX4(a, b, c, d) (MAX((a), MAX3((b), (c), (d))))
#define MIN4(a, b, c, d) (MIN((a), MIN3((b), (c), (d))))

//=================================================================

int main() {
  int n, x0, y0, x1, y1, x2, y2;
  int maxx, maxy, minx, miny;

  assert(scanf("%d", &n) == 1);

  assert(scanf("%d %d %d %d %d %d",
               &x0, &y0, &x1, &y1, &x2, &y2) == 6);

  maxx = MAX3(x0, x1, x2);
  minx = MIN3(x0, x1, x2);
  maxy = MAX3(y0, y1, y2);
  miny = MIN3(y0, y1, y2);

  for (int i = 2; i <= n; ++i) {
    assert(scanf("%d %d %d %d %d %d",
                 &x0, &y0, &x1, &y1, &x2, &y2) == 6);

    maxx = MAX4(maxx, x0, x1, x2);
    minx = MIN4(minx, x0, x1, x2);
    maxy = MAX4(maxy, y0, y1, y2);
    miny = MIN4(miny, y0, y1, y2);
  }

  printf("%d %d %d %d\n", minx, miny, maxx, maxy);
  return 0;
}