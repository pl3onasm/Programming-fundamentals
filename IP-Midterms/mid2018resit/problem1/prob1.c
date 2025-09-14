/* file: prob1.c
* author: David De Potter
* description: problem 1, minimum bounding rectangle, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((b) > (a) ? (a) : (b))

int main (int argc, char *argv[]) {
  int n, x0, y0, x1, y1, x2, y2;
  int maxx = 0, maxy = 0, minx = 1000000, miny = 1000000;

  (void)! scanf ("%d", &n);

  for (int i = 1; i <=n; ++i) {
    (void)! scanf("%d %d %d %d %d %d", &x0, &y0, &x1, &y1, &x2, &y2);
    maxx = MAX(MAX(x0, x1), MAX(x2, maxx));
    maxy = MAX(MAX(y0, y1), MAX(y2, maxy));
    minx = MIN(MIN(x0, x1), MIN(x2, minx));
    miny = MIN(MIN(y0, y1), MIN(y2, miny));
  }

  printf("%d %d %d %d\n", minx, miny, maxx, maxy);
  return 0;
}
