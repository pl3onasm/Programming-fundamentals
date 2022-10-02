/* file: rectangle.c
* author: David De Potter
* description: problem 1, minimum bounding rectangle, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int max (int x, int y) {
  return (x > y ? x : y);
}

int min (int x, int y) {
  return (x < y ? x : y);
}

int main (int argc, char *argv[]) {
  int n, x0, y0, x1, y1, x2, y2;
  int maxx=0, maxy=0, minx=1000000, miny=1000000;
  scanf ("%d", &n);
  for (int i = 1; i <=n; ++i) {
    scanf("%d %d %d %d %d %d", &x0, &y0, &x1, &y1, &x2, &y2);
    maxx = max(max(x0, x1), max(x2, maxx));
    maxy = max(max(y0, y1), max(y2, maxy));
    minx = min(min(x0, x1), min(x2, minx));
    miny = min(min(y0, y1), min(y2, miny));
  }
  printf("%d %d %d %d\n", minx, miny, maxx, maxy);
  return 0;
}
